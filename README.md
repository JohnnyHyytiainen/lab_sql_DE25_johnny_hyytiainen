Struktur för **lab** i kursen SQL (Data Engineer 2025).  
Kod körs som `.py` och `.ipynb` Virtuell miljö `uv venv` används för renare paketversioner.

## Innehåll
- [Syfte](#syfte)
- [Miljö & versioner](#miljö--versioner)
- [Struktur](#struktur)
- [Körning](#körning)
- [Exempeloutput](#exempeloutput)

## Syfte
- Tydlig data-/plots-/tests-struktur.
- Enkelt att klona och köra.
- Källor/anteckningar i `notes.md`.

## Miljö & versioner
- **Python:** 3.12+ (Testad på 3.13.5)


## Snabbstart
**Windows (PowerShell):**
```powershell
py -m venv .venv
.\.venv\Scripts\Activate.ps1
python -m pip install --upgrade pip
python -m pip install -r requirements.txt
```

## Struktur
  - `data/` med relevanta filer (t.ex. PDF med uppgiftstext).
  - Python-skript (`.py` `.ipynb`) som löser uppgifterna. T.ex. EDA
  - `notes.md` med källor och vad jag fått hjälp med (radintervall + länk).