# 2. Use DuckDB for the analytics layer

Status: accepted (<!-- date -->)

## Context
The pipeline aggregates a large set of symbols and needs fast local analytical queries. The team runs on-prem and does not want the operational overhead of a standalone data warehouse.

## Decision
Use DuckDB for the SQL-facing analytics layer and Polars for transforms; read Parquet directly. Rejected Postgres for this layer — it adds infrastructure we do not need yet.

## Consequences
+ Zero infra, columnar speed, reads Parquet without a load step.
- Weak on concurrent writes. If we later need multi-writer access, write a new ADR that supersedes this one.
