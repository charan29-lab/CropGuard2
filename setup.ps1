Write-Host "========================================"
Write-Host "        CropGuard Setup"
Write-Host "========================================"
Write-Host ""

# Check Flutter
Write-Host "[1/5] Checking Flutter..."
if (Get-Command flutter -ErrorAction SilentlyContinue) {
    flutter --version
} else {
    Write-Host "ERROR: Flutter is not installed or not in PATH."
    exit 1
}

# Check Git
Write-Host ""
Write-Host "[2/5] Checking Git..."
if (Get-Command git -ErrorAction SilentlyContinue) {
    git --version
} else {
    Write-Host "ERROR: Git is not installed or not in PATH."
    exit 1
}

# Check Android SDK
Write-Host ""
Write-Host "[3/5] Checking Android SDK..."

$androidSdk = $env:ANDROID_HOME

if (-not $androidSdk) {
    $androidSdk = $env:ANDROID_SDK_ROOT
}

if ($androidSdk) {
    Write-Host "Android SDK: $androidSdk"
} else {
    Write-Host "WARNING: ANDROID_HOME / ANDROID_SDK_ROOT is not set."
    Write-Host "Flutter may still find the SDK through Android Studio."
}

# Check NDK
Write-Host ""
Write-Host "[4/5] Checking Android NDK..."

if ($androidSdk) {
    $ndkPath = Join-Path $androidSdk "ndk"

    if (Test-Path $ndkPath) {
        Write-Host "NDK directory found: $ndkPath"
        Get-ChildItem $ndkPath | Select-Object Name
    } else {
        Write-Host "WARNING: NDK directory was not found."
    }
} else {
    Write-Host "Skipping NDK check because Android SDK path was not found."
}

# Install Flutter packages
Write-Host ""
Write-Host "[5/5] Installing Flutter dependencies..."

flutter pub get

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: flutter pub get failed."
    exit 1
}

Write-Host ""
Write-Host "========================================"
Write-Host "       CropGuard Setup Complete"
Write-Host "========================================"
Write-Host ""
Write-Host "Run the app with:"
Write-Host "    flutter run -d chrome"
Write-Host ""
Write-Host "For Android:"
Write-Host "    flutter devices"
Write-Host "    flutter run"
Write-Host ""