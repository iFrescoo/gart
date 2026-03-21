# Python Conventions

## Applies When
Python files (`**/*.py`)

## Rules

### Type Annotations (PEP 484)
- Add type hints to all function signatures
- Use `from __future__ import annotations` for forward references
- Prefer `Protocol` over `ABC` for structural typing
- Use `TypeVar` for generic functions

### Modern Python (3.10+)
- `match/case` for complex branching
- `str | None` instead of `Optional[str]`
- `list[str]` instead of `List[str]`
- f-strings for string formatting (not `.format()` or `%`)
- `dataclasses` or `pydantic.BaseModel` for data structures

### Code Style
- Follow PEP 8 (enforced by `ruff` linter)
- Max line length: 88 (Black default)
- Use `ruff` for linting and formatting
- Snake_case for functions/variables, PascalCase for classes

### Async
- Use `async/await` with `asyncio` (not threads for I/O)
- Don't mix sync and async code without explicit boundaries
- Use `asyncio.gather()` for concurrent operations

### Virtual Environments
- Always use `venv` or `poetry` — never install globally
- Pin dependencies in `requirements.txt` or `pyproject.toml`
- Separate dev dependencies from production

### Testing
- Use `pytest` (not `unittest`)
- Use `pytest.fixture` for setup/teardown
- Use `pytest.mark.parametrize` for data-driven tests
