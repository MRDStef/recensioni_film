import { HttpClient, provideHttpClient, withFetch } from '@angular/common/http';
import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
import { toSignal } from '@angular/core/rxjs-interop';
import { catchError, forkJoin, map, of } from 'rxjs';

/**
 * Contratto API previsto (Slim backend):
 *
 * GET /api/film/evidenza
 * → { titolo, descrizione, locandine: [{ id, url, alt? }] }
 *
 * GET /api/film?genere=Azione&limit=4
 * → FilmResponse[]
 */

const API_BASE_URL = 'http://localhost:8080/api';
const GENERI_HOME = ['Azione', 'Commedia', 'Drammatico'] as const;

interface LocandinaResponse {
  id: number;
  url: string;
  alt?: string;
}

interface FilmEvidenzaResponse {
  titolo: string;
  descrizione: string;
  locandine: LocandinaResponse[];
}

interface FilmResponse {
  id_film: number;
  titolo: string;
  genere: string;
  regista?: string;
  data_pubblicazione?: string;
  anno?: number;
  descrizione?: string;
  locandina_url?: string;
}

interface MovieCard {
  id: number;
  title: string;
  year: number;
  posterUrl?: string;
}

interface Category {
  name: string;
  movies: MovieCard[];
}

function extractYear(film: FilmResponse): number {
  if (film.anno) {
    return film.anno;
  }
  if (film.data_pubblicazione) {
    return Number(film.data_pubblicazione.slice(0, 4));
  }
  return 0;
}

function mapFilmToCard(film: FilmResponse): MovieCard {
  return {
    id: film.id_film,
    title: film.titolo,
    year: extractYear(film),
    posterUrl: film.locandina_url,
  };
}

@Component({
  selector: 'app-home',
  imports: [],
  providers: [provideHttpClient(withFetch())],
  templateUrl: './home.html',
  styleUrl: './home.css',
  changeDetection: ChangeDetectionStrategy.OnPush,
})
export class Home {
  private readonly http = inject(HttpClient);

  readonly featured = toSignal(
    this.http.get<FilmEvidenzaResponse>(`${API_BASE_URL}/film/evidenza`).pipe(
      catchError(() => of(null)),
    ),
    { initialValue: null as FilmEvidenzaResponse | null },
  );

  readonly categories = toSignal(
    forkJoin(
      GENERI_HOME.map((genere) =>
        this.http
          .get<FilmResponse[]>(`${API_BASE_URL}/film`, {
            params: { genere, limit: '4' },
          })
          .pipe(
            map((films) => ({
              name: genere,
              movies: films.map(mapFilmToCard),
            })),
            catchError(() => of({ name: genere, movies: [] as MovieCard[] })),
          ),
      ),
    ),
    { initialValue: undefined as Category[] | undefined },
  );
}
