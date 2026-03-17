param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet('repo', 'user')]
    [string]$Mode,

    [string]$TargetRepo,
    [string[]]$Templates = @('AGENTS', 'CLAUDE', 'GEMINI', 'COPILOT'),
    [ValidateSet('claude', 'gemini')]
    [string]$Profile,
    [ValidateSet('AGENTS', 'CLAUDE', 'GEMINI', 'COPILOT')]
    [string]$Template,
    [string]$TargetFile,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

$rootDir = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$snippetDir = Join-Path $rootDir 'instruction-snippets'

function Get-TemplateSource([string]$name) {
    switch ($name) {
        'AGENTS' { return Join-Path $snippetDir 'AGENTS.md' }
        'CLAUDE' { return Join-Path $snippetDir 'CLAUDE.md' }
        'GEMINI' { return Join-Path $snippetDir 'GEMINI.md' }
        'COPILOT' { return Join-Path $snippetDir '.github/copilot-instructions.md' }
        default { throw "Unknown template: $name" }
    }
}

function Get-RepoDestination([string]$name) {
    switch ($name) {
        'AGENTS' { return 'AGENTS.md' }
        'CLAUDE' { return 'CLAUDE.md' }
        'GEMINI' { return 'GEMINI.md' }
        'COPILOT' { return '.github/copilot-instructions.md' }
        default { throw "Unknown template: $name" }
    }
}

function Copy-TemplateFile([string]$source, [string]$destination, [bool]$forceCopy) {
    $destinationDir = Split-Path -Parent $destination
    if (-not (Test-Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
    }

    if ((Test-Path $destination) -and -not $forceCopy) {
        Write-Host "SKIP  $destination (already exists; use -Force to overwrite)"
        return
    }

    Copy-Item -Path $source -Destination $destination -Force
    Write-Host "COPY  $source -> $destination"
}

if ($Mode -eq 'repo') {
    if (-not $TargetRepo) {
        throw 'TargetRepo is required for repo mode.'
    }

    foreach ($name in $Templates) {
        $source = Get-TemplateSource $name
        $destination = Join-Path $TargetRepo (Get-RepoDestination $name)
        Copy-TemplateFile -source $source -destination $destination -forceCopy $Force.IsPresent
    }
    exit 0
}

if ($Mode -eq 'user') {
    if ($Profile) {
        switch ($Profile) {
            'claude' {
                $Template = 'CLAUDE'
                $TargetFile = Join-Path $HOME '.claude/CLAUDE.md'
            }
            'gemini' {
                $Template = 'GEMINI'
                $TargetFile = Join-Path $HOME '.gemini/GEMINI.md'
            }
        }
    }

    if (-not $Template -or -not $TargetFile) {
        throw 'For user mode without -Profile, both -Template and -TargetFile are required.'
    }

    $source = Get-TemplateSource $Template
    Copy-TemplateFile -source $source -destination $TargetFile -forceCopy $Force.IsPresent
    exit 0
}
