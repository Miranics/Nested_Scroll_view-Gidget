<# Simple PowerShell static server for the presentation folder
   Usage:
     cd presentation
     powershell -ExecutionPolicy Bypass -File .\serve_presentation.ps1
#>

Param([int]$Port = 8000)

$prefix = "http://localhost:$Port/"
Write-Host "Starting server at $prefix"

$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($prefix)
try { $listener.Start() } catch { Write-Error "Could not start listener: $_"; exit 1 }

function Get-ContentType([string]$path) {
  switch ([System.IO.Path]::GetExtension($path).ToLower()) {
    '.html' { 'text/html' }
    '.htm'  { 'text/html' }
    '.css'  { 'text/css' }
    '.js'   { 'application/javascript' }
    '.json' { 'application/json' }
    '.png'  { 'image/png' }
    '.jpg'  { 'image/jpeg' }
    '.jpeg' { 'image/jpeg' }
    '.gif'  { 'image/gif' }
    '.svg'  { 'image/svg+xml' }
    default { 'application/octet-stream' }
  }
}

try {
  while ($listener.IsListening) {
    $context = $listener.GetContext()
    $req = $context.Request
    $rawPath = $req.Url.AbsolutePath.TrimStart('/') -replace '/','\\'
    if ([string]::IsNullOrEmpty($rawPath)) { $rawPath = 'index.html' }
    $localPath = Join-Path (Get-Location) $rawPath
    if (-not (Test-Path $localPath)) {
      if (Test-Path (Join-Path $localPath 'index.html')) { $localPath = Join-Path $localPath 'index.html' }
    }
    if (Test-Path $localPath) {
      $bytes = [System.IO.File]::ReadAllBytes($localPath)
      $context.Response.ContentType = Get-ContentType $localPath
      $context.Response.ContentLength64 = $bytes.Length
      $context.Response.OutputStream.Write($bytes, 0, $bytes.Length)
    } else {
      $context.Response.StatusCode = 404
      $resp = [System.Text.Encoding]::UTF8.GetBytes('404 - Not Found')
      $context.Response.OutputStream.Write($resp,0,$resp.Length)
    }
    $context.Response.OutputStream.Close()
  }
} finally {
  $listener.Stop(); $listener.Close()
}
