Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\Dell\.gemini\antigravity\brain\19b435ea-1494-4157-a713-6e6b751c7972\.user_uploaded\media_1788161247127.jpg"
$outDir = "e:\دارالتقوی ڈیٹا\images\slider"
if (!(Test-Path $outDir)) { New-Item -ItemType Directory -Path $outDir -Force }

$srcBmp = [System.Drawing.Bitmap]::FromFile($srcPath)

# Define crop boxes [X, Y, Width, Height, Name]
$crops = @(
    @{ Name = "slide_building"; X = 230; Y = 350; W = 310; H = 245 },
    @{ Name = "slide_dispensary"; X = 120; Y = 205; W = 245; H = 180 },
    @{ Name = "slide_ghusal_kafan"; X = 530; Y = 210; W = 185; H = 175 },
    @{ Name = "slide_ration"; X = 32; Y = 385; W = 200; H = 200 },
    @{ Name = "slide_ambulance"; X = 525; Y = 385; W = 205; H = 200 },
    @{ Name = "slide_education"; X = 60; Y = 585; W = 225; H = 185 },
    @{ Name = "slide_qurbani"; X = 265; Y = 625; W = 235; H = 180 },
    @{ Name = "slide_water_filter"; X = 470; Y = 585; W = 215; H = 185 }
)

foreach ($c in $crops) {
    $rect = New-Object System.Drawing.Rectangle($c.X, $c.Y, $c.W, $c.H)
    $cropped = $srcBmp.Clone($rect, $srcBmp.PixelFormat)
    $destFile = Join-Path $outDir "$($c.Name).jpg"
    $cropped.Save($destFile, [System.Drawing.Imaging.ImageFormat]::Jpeg)
    $cropped.Dispose()
    Write-Host "Saved $($c.Name).jpg ($($c.W)x$($c.H))"
}

$srcBmp.Dispose()

# Also copy into site_dist
$distSliderDir = "e:\دارالتقوی ڈیٹا\site_dist\images\slider"
if (!(Test-Path $distSliderDir)) { New-Item -ItemType Directory -Path $distSliderDir -Force }
Copy-Item "$outDir\*" -Destination $distSliderDir -Force

Get-ChildItem $outDir
