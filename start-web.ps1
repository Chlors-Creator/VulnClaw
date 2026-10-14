# VulnClaw Web UI launcher.
#
# Why the two env overrides: this checkout runs inside a confined harness, so
# everything VulnClaw writes must stay inside the repo.
#   * VULNCLAW_CONFIG_DIR -> CLI config/sessions/runs/kb/skills (config/settings.py)
#   * USERPROFILE         -> web/auth.py hardcodes Path.home()/".vulnclaw" for the
#                            web token and ignores VULNCLAW_CONFIG_DIR.
# Delete this file if you run VulnClaw outside the harness (defaults are fine there).

$ErrorActionPreference = 'Stop'
$ws = Split-Path -Parent $MyInvocation.MyCommand.Path

$env:USERPROFILE         = Join-Path $ws '.home'
$env:VULNCLAW_CONFIG_DIR = Join-Path $ws '.vulnclaw-home'
$env:TEMP                = Join-Path $ws '.tmp'
$env:TMP                 = $env:TEMP

Set-Location $ws
& (Join-Path $ws '.venv\Scripts\vulnclaw.exe') web @args
