 = New-Object -ComObject WScript.Shell
 = @(
    [Environment]::GetFolderPath('CommonStartMenu'),
    [Environment]::GetFolderPath('StartMenu')
)

 = Get-ChildItem -Path  -Recurse -Include *.lnk

 = foreach ( in ) {
    try {
         = .CreateShortcut(.FullName)
        # Check if TargetPath is not empty and ends with .exe (case insensitive)
        if (![string]::IsNullOrEmpty(.TargetPath) -and .TargetPath.EndsWith(".exe", [StringComparison]::OrdinalIgnoreCase)) {
            [PSCustomObject]@{
                Name = .BaseName
                Path = .TargetPath
            }
        }
    } catch {}
}

# Remove duplicates based on Name and Path
 =  | Sort-Object -Property Name -Unique

 | Select-Object Name, Path | ConvertTo-Json
