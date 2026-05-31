# Deprecato: usare download-posters-tmdb.ps1 per locandine uniche da TMDB.
$dest = Join-Path $PSScriptRoot "..\php\public\uploads\locandine"
$src = @{
  scifi1 = "locandine_6a1aedc5e9f832.56698675.jpg"
  scifi2 = "locandine_6a1aee40e669e2.92591412.jpg"
  scifi3 = "locandine_6a1aeb814a9531.26937146.jpg"
  anim1  = "locandine_6a1aeef042d973.65208877.jpg"
  anim2  = "locandine_6a1aef9e398446.89072004.jpg"
  anim3  = "locandine_6a1aeaaa586d52.49902418.jpg"
  anim4  = "locandine_6a1aeb0bcf7ff9.72393578.jpg"
  drama  = "locandine_6a1aea06b6be39.75235597.jpg"
}

$map = @{
  "catalog_f01.jpg" = "scifi1"; "catalog_f02.jpg" = "scifi2"; "catalog_f03.jpg" = "scifi3"
  "catalog_f04.jpg" = "scifi1"; "catalog_f05.jpg" = "scifi2"; "catalog_f06.jpg" = "scifi3"
  "catalog_f07.jpg" = "anim1";  "catalog_f08.jpg" = "anim2";  "catalog_f09.jpg" = "anim1"
  "catalog_f10.jpg" = "anim2";  "catalog_f11.jpg" = "anim3";  "catalog_f12.jpg" = "anim4"
  "catalog_f13.jpg" = "drama";  "catalog_f14.jpg" = "drama";  "catalog_f15.jpg" = "anim3"
  "catalog_f16.jpg" = "anim4";  "catalog_f17.jpg" = "drama";  "catalog_f18.jpg" = "anim3"
  "catalog_f19.jpg" = "scifi3"; "catalog_f20.jpg" = "scifi2"; "catalog_f21.jpg" = "scifi1"
  "catalog_f22.jpg" = "anim4";  "catalog_f23.jpg" = "scifi2"; "catalog_f24.jpg" = "scifi3"
  "catalog_f25.jpg" = "anim1";  "catalog_f26.jpg" = "anim3";  "catalog_f27.jpg" = "anim2"
  "catalog_f28.jpg" = "anim1";  "catalog_f29.jpg" = "anim2";  "catalog_f30.jpg" = "anim3"
  "catalog_f31.jpg" = "drama";  "catalog_f32.jpg" = "anim4";  "catalog_f33.jpg" = "drama"
  "catalog_f34.jpg" = "anim3";  "catalog_f35.jpg" = "anim4";  "catalog_f36.jpg" = "scifi3"
}

foreach ($entry in $map.GetEnumerator()) {
  $from = Join-Path $dest $src[$entry.Value]
  $to = Join-Path $dest $entry.Key
  Copy-Item $from $to -Force
}
Write-Host "Assigned $($map.Count) catalog posters."
