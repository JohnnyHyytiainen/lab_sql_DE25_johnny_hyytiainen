# Kommentater: Svenska
# Kod: Engelska
# Syfte: Göra robusta paths och idempotent. == .duckdb filen behöver ej raderas. DLT öppnar den bara
# Syfte: Bygga/uppdatera sakila.duckdb från sqlite-sakila.db med DLT
# Syfte: Göra EDA sidan till att alltid vara read only
# Körs från terminalen, inte från notebook

from pathlib import Path

import dlt
from dlt.sources.sql_database import sql_database


def get_paths() -> tuple[Path, Path]:
    """Find repo-root and build paths to SQLite and DUCKDB."""
    here = Path(__file__).resolve()
    pkg_dir = here.parent        # /src/lab_sql_de25_johnny_hyytiainen
    src_dir = pkg_dir.parent     # /src
    root_dir = src_dir.parent    # /lab_sql_DE25_johnny_hyytiainen

    sqlite_path = root_dir / "db" / "sqlite-sakila.db"
    duckdb_path = root_dir / "db" / "sakila.duckdb"
    return sqlite_path, duckdb_path


def run() -> None:
    """Run entire ingestion with DLT."""
    sqlite_path, duckdb_path = get_paths()

    if not sqlite_path.exists():
        raise FileNotFoundError(f"Sakila SQLite missing: {sqlite_path}")

    print(f"SQLite:  {sqlite_path}")
    print(f"DuckDB:  {duckdb_path}")

    source = sql_database(
        credentials=f"sqlite:///{sqlite_path}",
        schema="main",  # SQLite main schema
    )

    pipeline = dlt.pipeline(
        pipeline_name="sakila_sqlite_to_duckdb",
        destination=dlt.destinations.duckdb(str(duckdb_path)),
        dataset_name="staging",
    )

    # Viktigt: replace = säkert att köra hur många gånger som helst
    load_info = pipeline.run(source, write_disposition="replace")
    print(load_info)


if __name__ == "__main__":
    run()
