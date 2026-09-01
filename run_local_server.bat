@echo off
title Khair Ummah Local Server
echo Starting Local Server on http://localhost:8000 ...
start http://localhost:8000
powershell -NoProfile -Command "$listener = New-Object System.Net.HttpListener; $listener.Prefixes.Add('http://localhost:8000/'); $listener.Start(); Write-Host 'Server running at http://localhost:8000/ (Press Ctrl+C to stop)'; while($listener.IsListening){ $context = $listener.GetContext(); $response = $context.Response; $file = 'e:\دارالتقوی ڈیٹا\index.html'; if(Test-Path $file){ $bytes = [System.IO.File]::ReadAllBytes($file); $response.ContentType = 'text/html; charset=utf-8'; $response.ContentLength64 = $bytes.Length; $response.OutputStream.Write($bytes, 0, $bytes.Length); } else { $response.StatusCode = 404; } $response.Close(); }"
pause
