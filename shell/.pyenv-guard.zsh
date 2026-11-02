# Pyenv without "pyenv init" (init always runs rehash in 2.6.x and races on Cursor launch).

export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
# Fail fast if rehash is ever invoked — never block for 60s.
export PYENV_REHASH_TIMEOUT=3

_pyenv_clear_lock() {
  command rm -f "${PYENV_ROOT}/shims/.pyenv-shim"
}

_pyenv_setup_path() {
  _pyenv_clear_lock
  [[ -d "${PYENV_ROOT}/bin" ]] && export PATH="${PYENV_ROOT}/bin:${PATH}"
  [[ -d "${PYENV_ROOT}/shims" ]] && export PATH="${PYENV_ROOT}/shims:${PATH}"
}

pyenv-rehash() {
  _pyenv_clear_lock
  command pyenv rehash "$@"
}

pyenv() {
  if [[ "${1:-}" == "rehash" ]]; then
    shift
    pyenv-rehash "$@"
  else
    command pyenv "$@"
  fi
}

_pyenv_setup_path
