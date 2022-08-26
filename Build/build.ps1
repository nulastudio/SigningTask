$workingdir = $pwd
$builddir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$rootdir = "${builddir}/.."
$nupkgdir = "${builddir}/nupkg"

# 清理
if (Test-Path -Path $nupkgdir) {
    Remove-Item -Recurse -Force $nupkgdir
    mkdir $nupkgdir
}

# 清理NetBeauty Nuget缓存
$cachedir = $(dotnet nuget locals global-packages -l).Replace("global-packages: ", "")
$cachedir = "${cachedir}/nulastudio.signingtask"

if (Test-Path -Path $cachedir) {
    Remove-Item -Recurse -Force $cachedir
}

# 编译SigningTask
cd "${rootdir}/SigningTask"
dotnet pack -c Release /p:PackageOutputPath=${nupkgdir}

cd $workingdir
