$dest = Join-Path $PSScriptRoot "..\php\public\uploads\locandine"
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$posters = @(
  @{ file = "poster_01_inception.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/2/2e/Inception_%282010%29_theatrical_poster.jpg" },
  @{ file = "poster_02_interstellar.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg" },
  @{ file = "poster_03_matrix.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/c/c1/The_Matrix_Poster.jpg" },
  @{ file = "poster_04_blade_runner.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/9/9b/Blade_Runner_2049_poster.png" },
  @{ file = "poster_05_arrival.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/d/df/Arrival%2C_Movie_Poster.jpg" },
  @{ file = "poster_06_dune.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/5/5d/Dune2021OfficialPoster.jpg" },
  @{ file = "poster_07_shrek.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/4/4d/Shrek_%28character%29.png" },
  @{ file = "poster_08_shrek2.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/b/b9/Shrek_2_poster.jpg" },
  @{ file = "poster_09_toystory.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/1/13/Toy_Story.jpg" },
  @{ file = "poster_10_lionking.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/3/3d/Lionkingposter.jpg" },
  @{ file = "poster_11_insideout.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/0/0a/Inside_Out_%282015_film%29_poster.jpg" },
  @{ file = "poster_12_spiderverse.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/0/0b/Spider-Man-_Across_the_Spider-Verse_poster.jpg" },
  @{ file = "poster_13_godfather.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/1/1c/Godfather_ver1.jpg" },
  @{ file = "poster_14_forrestgump.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/6/6a/Forrest_Gump_poster.jpg" },
  @{ file = "poster_15_parasite.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/5/53/Parasite_%282019_film%29.png" },
  @{ file = "poster_16_12angrymen.jpg"; url = "https://upload.wikimedia.org/wikipedia/commons/4/4f/12_Angry_Men_%281957_film_poster%29.jpeg" },
  @{ file = "poster_17_schindler.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/3/38/Schindler%27s_List_movie.jpg" },
  @{ file = "poster_18_whiplash.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/0/01/Whiplash_poster.jpg" },
  @{ file = "poster_19_darkknight.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/8/8a/Dark_Knight.jpg" },
  @{ file = "poster_20_madmax.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/2/23/Mad_Max_Fury_Road.jpg" },
  @{ file = "poster_21_gladiator.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/f/fb/Gladiator_%282000_film_poster%29.png" },
  @{ file = "poster_22_diehard.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/7/7e/Die_hard.jpg" },
  @{ file = "poster_23_missionimpossible.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/e/e1/MissionImpossibleFalloutPoster.jpg" },
  @{ file = "poster_24_johnwick.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/9/98/John_Wick_TeaserPoster.jpg" },
  @{ file = "poster_25_vitaebella.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/7/7c/La_vita_%C3%A8_bella.jpg" },
  @{ file = "poster_26_lebowski.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/c/c4/The_Big_Lebowski.jpg" },
  @{ file = "poster_27_superbad.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/8/8b/Superbad_Poster.png" },
  @{ file = "poster_28_meangirls.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/a/ac/Mean_Girls_2004_film_poster.png" },
  @{ file = "poster_29_hangover.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/b/b9/Hangoverposter09.jpg" },
  @{ file = "poster_30_loveactually.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/e/ef/Love_Actually_movie.jpg" },
  @{ file = "poster_31_usualsuspects.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/4/4c/The_Usual_Suspects_%28logo%29.png" },
  @{ file = "poster_32_se7en.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/6/6c/Seven_%28movie%29_poster.jpg" },
  @{ file = "poster_33_silence.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/8/86/The_Silence_of_the_Lambs_%28film_poster%29.jpeg" },
  @{ file = "poster_34_gonegirl.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/0/05/Gone_Girl_Poster.jpg" },
  @{ file = "poster_35_zodiac.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/3/3a/Zodiac2007Poster.jpg" },
  @{ file = "poster_36_shutterisland.jpg"; url = "https://upload.wikimedia.org/wikipedia/en/8/8a/Shutter_Island_poster.jpg" }
)

$fallback = Get-ChildItem $dest -Filter "locandine_*.jpg" | Select-Object -First 1
$i = 0

foreach ($p in $posters) {
  $out = Join-Path $dest $p.file
  try {
    Invoke-WebRequest -Uri $p.url -OutFile $out -UseBasicParsing -TimeoutSec 30
    Write-Host "OK $($p.file)"
  } catch {
    if ($fallback) {
      Copy-Item $fallback.FullName $out -Force
      Write-Host "FALLBACK $($p.file)"
    }
    $i++
  }
}

Write-Host "Done. Files in $dest"
