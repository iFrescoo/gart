# LLM Comparison — Multi-Agent Routing Strategy (March 2026)

> Strategiczny raport porównawczy modeli LLM dla systemów wieloagentowych. Fokus: optymalizacja cost-to-performance przez dynamiczny routing między darmowymi (NVIDIA NIM) a płatnymi API.

---

## Benchmark Landscape 2026

Stare benchmarki (MMLU, HumanEval, GSM8K) są **nasycone** — wszystkie frontier models >90%. Nowe miary:

| Benchmark                      | Co mierzy                                     | Dlaczego ważny                     |
| ------------------------------ | --------------------------------------------- | ---------------------------------- |
| **HLE** (Humanity's Last Exam) | Płynna inteligencja, ekspertyza doktorska     | Nienasycony, różnicuje top modele  |
| **ARC-AGI-2**                  | Abstrakcyjne wnioskowanie, fluid intelligence | Testuje zdolności niewyuczone      |
| **SWE-bench Pro**              | Realne bugi z GitHub repos                    | Odpowiednik produkcyjny dla coding |
| **Terminal-Bench 2.0**         | Autonomia CLI/Bash                            | Agentowa obsługa terminala         |
| **OSWorld**                    | Computer Use (GUI automation)                 | Sterowanie systemem graficznym     |
| **MRCR v2 (1M ctx)**           | Retrieval w 1M tokenach                       | RAG przy ekstremalnym kontekście   |

---

## Domain 1: Reasoning & Logic

### Commercial Leaders

| Model               | HLE   | ARC-AGI-2 | GPQA Diamond | Koszt ($/1M in) |
| ------------------- | ----- | --------- | ------------ | --------------- |
| **GPT-5.4**         | 41.6% | 74.0%     | 92.0%        | $2.50           |
| **Claude Opus 4.6** | 36.7% | **68.8%** | 91.3%        | $15.00          |
| **Gemini 3.1 Pro**  | 37.2% | 77.1%     | **94.3%**    | $2.00           |

### Free Alternatives (NVIDIA NIM)

| Model                          | HLE (szac.) | ARC-AGI-2 (szac.) | GPQA Diamond           | Koszt |
| ------------------------------ | ----------- | ----------------- | ---------------------- | ----- |
| **Nemotron 3 Super 120B A12B** | ~28%        | ~65%              | 82.7%                  | $0    |
| **Qwen3-Next-80B-Thinking**    | N/A         | N/A               | N/A (~75-80% MMLU-Pro) | $0    |

**Routing rule:** Darmowe dla ≥80% standardowych decyzji. Eskalacja do GPT-5.4 tylko gdy wymagana absolutna precyzja logiczna (tier-0 planning).

---

## Domain 2: Coding & Debugging

### Commercial Leaders

| Model               | SWE-bench Verified | Terminal-Bench 2.0 | HumanEval | Koszt ($/1M in) |
| ------------------- | ------------------ | ------------------ | --------- | --------------- |
| **Claude Opus 4.6** | **80.8%**          | 65.4%              | 95.0%     | $15.00          |
| **GPT-5.3 Codex**   | ~80.0%             | **77.3%**          | 93.0%     | Płatne          |

Claude Opus 4.6 — mistrz głębokiej inżynierii, "Agent Teams" (symultaniczne subagenty), 1M ctx.
GPT-5.3 Codex — mistrz terminala i szybkiej iteracji z człowiekiem (25% szybszy od 5.2).

### Free Alternatives (NVIDIA NIM)

| Model                      | SWE-bench (szac.) | HumanEval  | Kontekst | TTFT   |
| -------------------------- | ----------------- | ---------- | -------- | ------ |
| **MiniMax-M2.5**           | ~70%              | **89.6%**  | Duże     | Dobry  |
| **Llama 4 Scout 17B/109B** | Niska             | MMLU 86.5% | 327K     | ~0.33s |

**Routing rule:**

- `MICRO` (<500 linii, testy, linting, dokumentacja) → MiniMax + Llama 4 Scout (NIM)
- `MACRO` (cross-repo, nowa architektura, wieloplikowe refaktoryzacje) → Claude Opus 4.6

---

## Domain 3: Vision & Multimodal

### Commercial Leaders

| Model              | Vision Arena ELO | MMMU-Pro  | OSWorld (Computer Use)          | Koszt ($/1M in) |
| ------------------ | ---------------- | --------- | ------------------------------- | --------------- |
| **Gemini 3.1 Pro** | ~1290            | **80.5%** | N/A                             | $2.00           |
| **GPT-5.4**        | ~1265            | Wysoki    | **75.0%** _(beats human 72.4%)_ | $2.50           |

Gemini 3.1 Pro — 2M ctx, absolutny lider Vision RAG i wideo.
GPT-5.4 — jedyny model, który wyprzedził ludzki baseline w Computer Use (GUI automation).

### Free Alternatives (NVIDIA NIM)

| Model                  | Specjalizacja                          | Parametry  | Koszt |
| ---------------------- | -------------------------------------- | ---------- | ----- |
| **Cosmos Reason 2 8B** | Physical AI, układy dokumentów, kamery | 8B         | $0    |
| **Phi-4-multimodal**   | OCR, pismo odręczne, tabele, paragony  | 14B / 128K | $0    |

**Routing rule:**

- Vision RAG, OCR, PDF, parsowanie → Cosmos + Phi-4 (NIM)
- Wideo long-form → Gemini 3.1 Pro
- Computer Use / RPA / DOM navigation → GPT-5.4

---

## Domain 4: RAG & Long-Context Text

### Commercial Leaders

| Model                 | Kontekst | PinchBench (RAG) | MRCR v2 (1M retrieval) | Koszt ($/1M in) |
| --------------------- | -------- | ---------------- | ---------------------- | --------------- |
| **Claude Sonnet 4.6** | ~200K    | **86.9%**        | Wysoki                 | $3.00           |
| **Claude Opus 4.6**   | 1M       | Wysoki           | **76%**                | $15.00          |

Claude Sonnet 4.6 = złoty środek produkcyjny dla RAG. Opus = tier-0 (legal, MRCR-level retrieval).

### Free Alternatives (NVIDIA NIM)

| Model                          | Kontekst | Mocne strony                                           | Słabe strony               |
| ------------------------------ | -------- | ------------------------------------------------------ | -------------------------- |
| **Nemotron 3 Super 120B A12B** | 1M       | Mamba-2 MTP, 2.2–7.5× szybszy niż open-source          | Context Dilution >500–600K |
| **Mistral Large 3 (2512)**     | 256K     | Multilingual, szybki dispatcher, instruction following | Mniejszy kontekst          |

**Routing rule:**

- Dokumentacja wewnętrzna, PDF, tłumaczenia, pre-processing → Nemotron + Mistral (NIM)
- "Igła w stogu siana" w prawnych/naukowych dokumentach → Claude Opus 4.6
- Produkcyjny wolumen RAG → Claude Sonnet 4.6

---

## Master Routing Table

```
Task Category              │ Free (NIM)              │ Paid API
───────────────────────────┼─────────────────────────┼──────────────────────────
Linting / micro-scripts    │ Llama 4 Scout            │ —
Unit tests / TDD           │ MiniMax-M2.5             │ —
Code generation <500 LOC   │ MiniMax-M2.5             │ —
OCR / PDF / paragony       │ Phi-4-multimodal         │ —
Vision RAG                 │ Cosmos Reason 2 8B       │ —
RAG dispatcher / tłum.     │ Mistral Large 3          │ —
RAG biznesowy (std.)       │ Nemotron 3 Super         │ —
Wnioskowanie (std.)        │ Nemotron / Qwen3-Thinking│ —
───────────────────────────┼─────────────────────────┼──────────────────────────
Produkcyjny RAG (masowy)   │ Nemotron (primary)       │ Claude Sonnet 4.6 (fallback)
Refaktor cross-repo        │ —                        │ Claude Opus 4.6
Legal / MRCR retrieval     │ —                        │ Claude Opus 4.6
Tier-0 planning            │ —                        │ GPT-5.4 / Claude Opus 4.6
Computer Use / RPA         │ —                        │ GPT-5.4
Wideo long-form analysis   │ —                        │ Gemini 3.1 Pro
```

---

## Cost-to-Performance Summary

| Strategia               | Potencjalne oszczędności | Ryzyko                              |
| ----------------------- | ------------------------ | ----------------------------------- |
| NIM dla mikro-kodowania | ~90% vs Opus             | Niskie — jakość nierozróżnialna     |
| NIM dla RAG (standard)  | ~85% vs Sonnet           | Niskie — sprawdzić przy >500K ctx   |
| NIM dla Vision RAG      | ~95% vs Gemini           | Niskie — poza Computer Use          |
| NIM dla Reasoning       | ~70% vs GPT-5.4          | Średnie — monitorować halucynacje   |
| Paid dla Macro-coding   | —                        | Niezbędne — NIM nie poradzi sobie   |
| Paid dla tier-0 RAG     | —                        | Niezbędne — MRCR v2 gap jest realny |

**Konkluzja architektoniczna:** ≥80% ruchu można obsłużyć darmowo przez NVIDIA NIM. Kluczem jest Complexity Estimator w orkiestratorze — bez niego system albo przepala budżet, albo halucynuje w miejscach krytycznych.

---

_Źródła: benchmarki z marca 2026 — HLE, ARC-AGI-2, SWE-bench Pro, Terminal-Bench 2.0, OSWorld, MRCR v2, PinchBench, LMSYS Arena._
