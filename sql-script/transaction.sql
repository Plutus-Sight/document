CREATE TABLE account (
    code VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    balance NUMERIC NOT NULL DEFAULT 0,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE transaction_group (
    code VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE transaction (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    group_code VARCHAR NOT NULL,
    account_code VARCHAR NOT NULL,
    type VARCHAR CHECK (type IN ('INCOME', 'EXPENSE')) NOT NULL,
    amount NUMERIC NOT NULL,
    balance NUMERIC NOT NULL,
    date DATE NOT NULL,
    note VARCHAR,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT fk_transaction_group FOREIGN KEY (group_code) REFERENCES transaction_group (code),
    CONSTRAINT fk_transaction_account FOREIGN KEY (account_code) REFERENCES account (code)
);

CREATE TABLE credit_card (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    cycle_date INTEGER NOT NULL CHECK (cycle_date BETWEEN 1 AND 31),
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ
);

CREATE TABLE debt_transaction (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    credit_card_id UUID NOT NULL,
    amount NUMERIC NOT NULL,
    date DATE NOT NULL,
    note VARCHAR,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    deleted_at TIMESTAMPTZ,
    CONSTRAINT fk_debt_transaction_credit_card FOREIGN KEY (credit_card_id) REFERENCES credit_card (id)
);
