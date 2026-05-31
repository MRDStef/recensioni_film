import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
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
  featured: any = null;
  categories: any[] = [];
  caricamento: boolean = true;
  tuttiIFilm: any[] = [];
  slideCorrente: number = 0;

  constructor(
    private filmService: Film,
    private router: Router,
    public cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    this.filmService.getAll().subscribe({
      next: (film: any[]) => {
        this.tuttiIFilm = film;

        if (film.length > 0) {
           setTimeout(() => {
            this.aggiornaCorrente();
            this.cdr.detectChanges();
          }, 0);
        }

        if (film.length > 0) {
          const primo = film[0];
          this.featured = {
            titolo: primo.titolo,
            descrizione: primo.descrizione ?? 'Nessuna descrizione disponibile',
            locandine: [
              {
                id: 1,
                url: primo.locandina_url ? '/' + primo.locandina_url : null,
                alt: primo.titolo
              }
            ]
          };
        }

        const generi: { [key: string]: any[] } = {};
        film.forEach(f => {
          const genere = f.genere ?? 'Altro';
          if (!generi[genere]) generi[genere] = [];
          generi[genere].push({
            id: f.id_film,
            title: f.titolo,
            year: f.data_pubblicazione ? new Date(f.data_pubblicazione).getFullYear() : '',
            posterUrl: f.locandina_url ? '/' + f.locandina_url : null
          });
        });

        this.categories = Object.entries(generi).map(([name, movies]) => ({ name, movies }));
        this.caricamento = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.caricamento = false;
        this.cdr.detectChanges();
      }
    });
    this.cdr.detectChanges();
  }

  goToFilm(id: number): void {
    this.router.navigate(['/film', id]);
  }

  prossima(): void {
    this.slideCorrente = (this.slideCorrente + 1) % this.tuttiIFilm.length;
    this.aggiornaCorrente();
    this.cdr.detectChanges();
  }

  precedente(): void {
      this.slideCorrente = (this.slideCorrente - 1 + this.tuttiIFilm.length) % this.tuttiIFilm.length;
      this.aggiornaCorrente();
      this.cdr.detectChanges();
  }

  aggiornaCorrente(): void {
      const f = this.tuttiIFilm[this.slideCorrente];
      this.featured = {
          titolo: f.titolo,
          descrizione: f.descrizione ?? 'Nessuna descrizione disponibile',
          id: f.id_film,
          url: f.locandina_url ? '/' + f.locandina_url : null
      };
  }
}