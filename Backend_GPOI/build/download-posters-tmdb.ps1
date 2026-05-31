$dest = Join-Path $PSScriptRoot "..\php\public\uploads\locandine"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$films = @(
  @{ file = "catalog_f01.jpg"; slug = "27205-inception" },
  @{ file = "catalog_f02.jpg"; slug = "157336-interstellar" },
  @{ file = "catalog_f03.jpg"; slug = "603-the-matrix" },
  @{ file = "catalog_f04.jpg"; slug = "335984-blade-runner-2049" },
  @{ file = "catalog_f05.jpg"; slug = "329865-arrival" },
  @{ file = "catalog_f06.jpg"; slug = "438631-dune" },
  @{ file = "catalog_f07.jpg"; slug = "808-shrek" },
  @{ file = "catalog_f08.jpg"; slug = "809-shrek-2" },
  @{ file = "catalog_f09.jpg"; slug = "862-toy-story" },
  @{ file = "catalog_f10.jpg"; slug = "8587-the-lion-king" },
  @{ file = "catalog_f11.jpg"; slug = "150540-inside-out" },
  @{ file = "catalog_f12.jpg"; slug = "324857-spider-man-into-the-spider-verse" },
  @{ file = "catalog_f13.jpg"; slug = "238-the-godfather" },
  @{ file = "catalog_f14.jpg"; slug = "13-forrest-gump" },
  @{ file = "catalog_f15.jpg"; slug = "496243-parasite" },
  @{ file = "catalog_f16.jpg"; slug = "389-12-angry-men" },
  @{ file = "catalog_f17.jpg"; slug = "424-schindler-s-list" },
  @{ file = "catalog_f18.jpg"; slug = "244786-whiplash" },
  @{ file = "catalog_f19.jpg"; slug = "155-the-dark-knight" },
  @{ file = "catalog_f20.jpg"; slug = "76341-mad-max-fury-road" },
  @{ file = "catalog_f21.jpg"; slug = "98-gladiator" },
  @{ file = "catalog_f22.jpg"; slug = "562-die-hard" },
  @{ file = "catalog_f23.jpg"; slug = "353081-mission-impossible-fallout" },
  @{ file = "catalog_f24.jpg"; slug = "245891-john-wick" },
  @{ file = "catalog_f25.jpg"; slug = "637-life-is-beautiful" },
  @{ file = "catalog_f26.jpg"; slug = "115-the-big-lebowski" },
  @{ file = "catalog_f27.jpg"; slug = "8363-superbad" },
  @{ file = "catalog_f28.jpg"; slug = "10625-mean-girls" },
  @{ file = "catalog_f29.jpg"; slug = "18785-the-hangover" },
  @{ file = "catalog_f30.jpg"; slug = "508-love-actually" },
  @{ file = "catalog_f31.jpg"; slug = "629-the-usual-suspects" },
  @{ file = "catalog_f32.jpg"; slug = "807-se7en" },
  @{ file = "catalog_f33.jpg"; slug = "274-the-silence-of-the-lambs" },
  @{ file = "catalog_f34.jpg"; slug = "210577-gone-girl" },
  @{ file = "catalog_f35.jpg"; slug = "1944-zodiac" },
  @{ file = "catalog_f36.jpg"; slug = "11324-shutter-island" }
)

$ok = 0
foreach ($film in $films) {
  $out = Join-Path $dest $film.file
  $pageUrl = "https://www.themoviedb.org/movie/$($film.slug)"
  try {
    $html = (curl.exe -sL $pageUrl) | Out-String
    if ($html -match '"image":"(https://image\.tmdb\.org/t/p/w500/[^"]+\.jpg)"') {
      $imageUrl = $matches[1] -replace '\\/', '/'
      Invoke-WebRequest -Uri $imageUrl -OutFile $out -UseBasicParsing -TimeoutSec 60
      $size = (Get-Item $out).Length
      if ($size -lt 5000) { throw "File too small" }
      Write-Host "OK $($film.file) <- $($film.slug)"
      $ok++
      continue
    }
    throw "Poster not found in page"
  } catch {
    $seed = [Uri]::EscapeDataString($film.file)
    Invoke-WebRequest -Uri "https://picsum.photos/seed/$seed/400/600" -OutFile $out -UseBasicParsing -TimeoutSec 60
    Write-Host "FALLBACK $($film.file): $($_.Exception.Message)"
  }
}

$hashes = Get-ChildItem (Join-Path $dest "catalog_f*.jpg") | ForEach-Object { (Get-FileHash $_.FullName).Hash }
$unique = ($hashes | Select-Object -Unique).Count
Write-Host "Scaricati $ok poster TMDB su $($films.Count). File unici (hash): $unique."
