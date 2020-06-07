from src.calculator import add
import pytest


def test_add():
    result = add(1, 1)
    assert result == 2


def test_add_string():
    with pytest.raises(TypeError):
        add("Hello World!", 2)
