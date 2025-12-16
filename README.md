# SQL Lab – Sakila BI project (DE25)

Lab for the SQL course in the Data Engineer 2025 program at STI.

The goal of this repo is to show a small but realistic analytics pipeline:

- Ingest the classic **Sakila** movie-rental database from SQLite -> DuckDB with **DLT**.
- Explore the data with **SQL + Python (pandas/matplotlib)** in notebooks.
- Build a **Business Intelligence dashboard** with **Evidence** on top of DuckDB.

---

## Tech stack

- Python 3.13 (managed with **uv**)
- DuckDB
- DLT (Data Load Tool) – `dlt[sql-database, parquet]`
- Jupyter / ipykernel
- pandas, matplotlib
- Evidence (Node.js, Vite, Svelte) for the dashboard

All Python dependencies are defined in `pyproject.toml` and pinned via `uv.lock`.  

---

## Repository structure

```text
.
├─ db/
│  ├─ sqlite-sakila.db         # Source database (SQLite, local copy of Sakila)
│  └─ sakila.duckdb            # DuckDB created via DLT (staging schema)
│
├─ data/
│  ├─ raw/                     # Optional extra data files
│  └─ processed/               # Optional processed outputs / examples
│
├─ src/
│  └─ lab_sql_de25_johnny_hyytiainen/
│     ├─ __init__.py
│     └─ ingest_sakila_dlt.py  # DLT pipeline: SQLite -> DuckDB (idempotent)
│
├─ notebooks/
│  ├─ lab_sql_sakila_EDA.ipynb # Task 1–2: EDA in Python + SQL + plots
│  └─ ...                      # (extra notebooks if needed)
│
├─ sql/
│  └─ eda_queries.sql          # Most of my SQL queries used in the EDA notebook
│
├─ dashboard/
│  ├─ evidence.config.mjs      # Evidence config (DuckDB connection, project meta)
│  └─ pages/
│     ├─ index.md              # Main BI dashboard for the lab
│     └─ check_data.md         # Sanity check to get dashboard up and running prior to BI report 
│
├─ docs/
│  └─ visuals/                 # All saved visuals in .png, Exported diagrams (joins, pipeline, etc.)
│  │   └─ *.png
│  ├─ notes.md                 # References, links, and what I used help for
│  ├─ SQL_lab_visuals.md       # Mermaid ER-diagrams and process diagrams
│  └─ *.pdf                    # Both the entire lab assignment and my BI report containing the findings from the dashboard
│
├─ .gitignore
├─ .python-version
├─ pyproject.toml
└─ uv.lock
```

## Environment & setup
**1. Clone repository**  

```bash
git clone https://github.com/JohnnyHyytiainen/lab_sql_DE25_johnny_hyytiainen.git
cd lab_sql_DE25_johnny_hyytiainen
```  
**2. Create virtual environment & install deps with uv (optional, but recommended)**  
```bash
uv venv
```  
**install everything from pyproject.toml / uv.lock**  
```bash
uv sync
```


## How to run the lab
### 1. Build / refresh the DuckDB database (DLT ingestion)

From repo root:

```bash
uv run python -m lab_sql_de25_johnny_hyytiainen.ingest_sakila_dlt
```
### 2. Explore the data (EDA)  
Open `notebooks/lab_sql_sakila_EDA.ipynb` in VS Code or Jupyter and run all cells.

### 3. Start the Evidence dashboard
```bash
cd dashboard
npm install        # first time only
npm run sources    # run SQL sources in /sql
npm run dev        # open http://localhost:3000
```

# Documentation & references
All study notes and references are not duplicated in the README.  
Instead:

**docs/notes.md collects:**  
links to DuckDB, DLT and Evidence docs   
YouTube tutorials and blog posts used  
where and with what LLMs help were used  

**docs/visuals contains:**  
All saved flowcharts and diagrams that have been made for this lab in .png format  
Example: Mermaid diagrams for joins, aggregation flow (WHERE vs HAVING), and the Evidence pipeline  

**docs/SQL_lab_visuals.md contains:**  
A few of my most relevant diagrams made which I want focus to be on.  

This keeps the README focused, while docs/ holds the full learning trail and source transparency.