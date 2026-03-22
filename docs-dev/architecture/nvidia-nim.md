# NVIDIA NIM — Multi-Agent Routing Architecture

> Analiza platformy NVIDIA Build (NIM Inference Microservices) jako darmowego backendu dla systemów wieloagentowych (Mixture of Agents). Marzec 2026.

---

## Platform Overview

| Parameter       | Value                                               |
| --------------- | --------------------------------------------------- |
| Dostępne modele | 94+ wariantów architektonicznych                    |
| Limit darmowy   | ~40 RPM (Requests Per Minute) per model             |
| Infrastruktura  | DGX Cloud — limity zależne od globalnego obciążenia |
| Optymalizacja   | TensorRT-LLM, kwantyzacja NVFP4/FP8, NVLink         |

**Kluczowa zasada:** Skierowanie prostego zapytania do 675B modelu = wyczerpanie limitu + duże TTFT. Routing semantyczny to fundament.

---

## Model Catalog by Domain

### 1. Reasoning & Logic (Wnioskowanie i logika)

| Model                          | Architektura                          | Kontekst  | Mocne strony                                                              | Słabe strony                                          |
| ------------------------------ | ------------------------------------- | --------- | ------------------------------------------------------------------------- | ----------------------------------------------------- |
| **Nemotron 3 Super 120B A12B** | LatentMoE (Mamba-2 + MoE + Attention) | 1M tokens | Routing w przestrzeni ukrytej, zbliża się do GPT-5.3 w zadaniach ogólnych | Halucynacje przy zagnieżdżonych JSON schema >500K ctx |
| **Qwen3-Next-80B-Thinking**    | MoE 80B (aktywne A3B, 512 ekspertów)  | Duże      | Test-time compute, rywalizuje z 10× większymi w matematyce                | Słabnie przy humanistyce i kulturowym niuansie        |

**Kiedy używać:** ≥80% standardowych zadań decyzyjnych korporacyjnych. Fallback na GPT-5.4/Claude Opus tylko dla ekstremów (HLE, ARC-AGI-2).

---

### 2. Coding & Debugging (Generowanie i analiza kodu)

| Model                      | HumanEval       | SWE-bench (szac.) | Kontekst | Rola w orkiestratorze                                                        |
| -------------------------- | --------------- | ----------------- | -------- | ---------------------------------------------------------------------------- |
| **MiniMax-M2.5**           | 89.6%           | ~70%              | Duże     | Główny agent kodowania — generowanie funkcji, debug, refaktor do 500 linii   |
| **Llama 4 Scout 17B/109B** | MMLU-Pro 86.5%+ | Niska             | 327K     | Linting agent, drobne PR poprawki, dokumentacja z małych plików; TTFT ~0.33s |

**Kiedy używać:** Mikrozadania do ~500 linii, generowanie testów jednostkowych, linting, dokumentacja.
**Fallback na płatne:** Makro-architektura, cross-repo refaktoryzacja, wieloplikowe zmiany systemowe.

---

### 3. Vision & Multimodal (Obraz i multimodalność)

| Model                         | Parametry     | Specjalizacja                                                     | Ograniczenia                                                                                 |
| ----------------------------- | ------------- | ----------------------------------------------------------------- | -------------------------------------------------------------------------------------------- |
| **Cosmos Reason 2 8B**        | 8B            | Physical AI, detekcja układów dokumentów, analiza strumieni kamer | Słabnie na gęstych, niskokontrastowych strukturach (schematy mikroskopowe, defekty hutnicze) |
| **Phi-4-multimodal-instruct** | 14B, 128K ctx | OCR, pismo odręczne, skanowane paragony, tabele                   | Nie zastąpi Gemini/GPT przy Computer Use                                                     |

**Kiedy używać:** Vision RAG, konwersja PDF, OCR faktur, parsowanie stron WWW, latency-bound loops.
**Fallback na płatne:** Computer Use (GUI automation) → GPT-5.4; długie sekwencje wideo → Gemini 3.1 Pro.

---

### 4. RAG & Long-Context Text

| Model                          | Kontekst | Mocne strony                                                              | Słabe strony                                                                 |
| ------------------------------ | -------- | ------------------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| **Nemotron 3 Super 120B A12B** | 1M       | Mamba-2 MTP (2.2–7.5× szybciej), hybrydowa obsługa długich tekstów        | Context Dilution >500–600K tokenów, traci niuanse w sprzecznych regulaminach |
| **Mistral Large 3 (2512)**     | 256K     | 675B/41B aktywnych, wybitna wielojęzyczność, szybki instruction following | Mniejszy kontekst niż Nemotron                                               |

**Kiedy używać:** Dokumentacja wewnętrzna, raporty PDF, tłumaczenia, pre-processing (dispatcher role), ≥80% codziennego RAG.
**Fallback na płatne:** MRCR v2 "igła w stogu siana" → Claude Opus 4.6; duży wolumen produkcyjny RAG → Claude Sonnet 4.6.

---

## Routing Decision Framework

```
Incoming Task
     │
     ▼
[Complexity Estimator]
     │
     ├─ MICRO (generowanie, linting, OCR, tłumaczenie, dispatcher)
     │    └─► NVIDIA NIM FREE (MiniMax / Nemotron / Llama 4 Scout / Mistral)
     │
     ├─ STANDARD (RAG dokumenty biznesowe, refaktor <500 linii, analiza obrazów)
     │    └─► NVIDIA NIM FREE → jeśli halucynacja: fallback PAID
     │
     └─ CRITICAL (makro-architektura, legal RAG, Computer Use, ekstremalne wnioskowanie)
          └─► PAID API (Claude Opus 4.6 / GPT-5.4 / Gemini 3.1 Pro)
```

---

## Rate Limit Management

- 40 RPM per model = rotuj między modelami dla wysokiego throughput
- TTFT krytyczny dla pętli agentowych — preferuj Llama 4 Scout (0.33s) dla mikrozadań
- Globalny load DGX Cloud = planuj fallback na wypadek przeciążeń

---

## Key Takeaways

1. **≥80% standardowych operacji** można obsłużyć darmowo przez NIM bez utraty jakości
2. **MiniMax-M2.5** to rewelacja dla codziennego kodowania (89.6% HumanEval)
3. **Nemotron 3 Super** = darmowy odpowiednik dla RAG i wnioskowania (1M ctx)
4. **Bramki eskalacyjne** są obowiązkowe — bez nich system jest niestabilny
5. **Koszt utracony:** Używanie płatnych API dla mikrozadań = przepalanie budżetu bez ROI
