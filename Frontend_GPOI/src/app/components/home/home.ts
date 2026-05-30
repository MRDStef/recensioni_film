// import { HttpClient, provideHttpClient, withFetch } from '@angular/common/http';
// import { ChangeDetectionStrategy, Component, inject } from '@angular/core';
// import { toSignal } from '@angular/core/rxjs-interop';
// import { catchError, forkJoin, map, of } from 'rxjs';

// /**
//  * Contratto API previsto (Slim backend):
//  *
//  * GET /api/film/evidenza
//  * → { titolo, descrizione, locandine: [{ id, url, alt? }] }
//  *
//  * GET /api/film?genere=Azione&limit=4
//  * → FilmResponse[]
//  */

// const API_BASE_URL = 'http://localhost:8080/api';
// const GENERI_HOME = ['Azione', 'Commedia', 'Drammatico'] as const;

// interface LocandinaResponse {
//   id: number;
//   url: string;
//   alt?: string;
// }

// interface FilmEvidenzaResponse {
//   titolo: string;
//   descrizione: string;
//   locandine: LocandinaResponse[];
// }

// interface FilmResponse {
//   id_film: number;
//   titolo: string;
//   genere: string;
//   regista?: string;
//   data_pubblicazione?: string;
//   anno?: number;
//   descrizione?: string;
//   locandina_url?: string;
// }

// interface MovieCard {
//   id: number;
//   title: string;
//   year: number;
//   posterUrl?: string;
// }

// interface Category {
//   name: string;
//   movies: MovieCard[];
// }

// function extractYear(film: FilmResponse): number {
//   if (film.anno) {
//     return film.anno;
//   }
//   if (film.data_pubblicazione) {
//     return Number(film.data_pubblicazione.slice(0, 4));
//   }
//   return 0;
// }

// function mapFilmToCard(film: FilmResponse): MovieCard {
//   return {
//     id: film.id_film,
//     title: film.titolo,
//     year: extractYear(film),
//     posterUrl: film.locandina_url,
//   };
// }

// @Component({
//   selector: 'app-home',
//   imports: [],
//   providers: [provideHttpClient(withFetch())],
//   templateUrl: './home.html',
//   styleUrl: './home.css',
//   changeDetection: ChangeDetectionStrategy.OnPush,
// })
// export class Home {
//   private readonly http = inject(HttpClient);

//   readonly featured = toSignal(
//     this.http.get<FilmEvidenzaResponse>(`${API_BASE_URL}/film/evidenza`).pipe(
//       catchError(() => of(null)),
//     ),
//     { initialValue: null as FilmEvidenzaResponse | null },
//   );

//   readonly categories = toSignal(
//     forkJoin(
//       GENERI_HOME.map((genere) =>
//         this.http
//           .get<FilmResponse[]>(`${API_BASE_URL}/film`, {
//             params: { genere, limit: '4' },
//           })
//           .pipe(
//             map((films) => ({
//               name: genere,
//               movies: films.map(mapFilmToCard),
//             })),
//             catchError(() => of({ name: genere, movies: [] as MovieCard[] })),
//           ),
//       ),
//     ),
//     { initialValue: undefined as Category[] | undefined },
//   );
// }

import { Component, OnInit, signal } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Film } from '../../services/film';

@Component({
  selector: 'app-home',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './home.html',
  styleUrl: './home.css'
})
export class Home implements OnInit {
  featured = signal<any>(null);
  categories = signal<any[]>([]);

  constructor(private filmService: Film, private router: Router) {}

  ngOnInit(): void {
    this.filmService.getAll().subscribe({
      next: (film: any[]) => {
        // Film in evidenza — primo della lista
        if (film.length > 0) {
          const primo = film[0];
          this.featured.set({
            titolo: primo.titolo,
            descrizione: primo.descrizione ?? 'Nessuna descrizione disponibile',
            locandine: [
              {
                id: 1,
                url: primo.locandina_url ? 'http://localhost:8080/' + primo.locandina_url : null,
                alt: primo.titolo
              }
            ]
          });
        }

        // Categorie — raggruppa i film per genere
        const generi: { [key: string]: any[] } = {};
        film.forEach(f => {
          const genere = f.genere ?? 'Altro';
          if (!generi[genere]) generi[genere] = [];
          generi[genere].push({
            id: f.id_film,
            title: f.titolo,
            year: f.data_pubblicazione ? new Date(f.data_pubblicazione).getFullYear() : '',
            posterUrl: f.locandina_url ? 'http://localhost:8080/' + f.locandina_url : null
          });
        });

        this.categories.set(
          Object.entries(generi).map(([name, movies]) => ({ name, movies }))
        );
      },
      error: () => {
        console.error('Errore nel caricamento dei film');
      }
    });
  }

  goToFilm(id: number): void {
    this.router.navigate(['/film', id]);
  }
}