import { Component, OnInit, OnDestroy, ChangeDetectorRef } from '@angular/core';
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
export class Home implements OnInit, OnDestroy {
  featured: any = null;
  categories: any[] = [];
  caricamento: boolean = true;
  tuttiIFilm: any[] = [];
  slideCorrente: number = 0;
  slideTransitionState: 'idle' | 'fading-out' | 'fading-in' = 'idle';
  private autoplayTimer?: number;

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
        this.startAutoplay();
        this.cdr.detectChanges();
      },
      error: () => {
        this.caricamento = false;
        this.cdr.detectChanges();
      }
    });
    this.cdr.detectChanges();
  }

  ngOnDestroy(): void {
    this.stopAutoplay();
  }

  goToFilm(id: number): void {
    this.router.navigate(['/film', id]);
  }

  prossima(): void {
    this.changeSlide((this.slideCorrente + 1) % this.tuttiIFilm.length);
  }

  precedente(): void {
    this.changeSlide((this.slideCorrente - 1 + this.tuttiIFilm.length) % this.tuttiIFilm.length);
  }

  private changeSlide(index: number): void {
    if (index === this.slideCorrente || this.tuttiIFilm.length === 0) {
      return;
    }

    this.stopAutoplay();
    this.slideTransitionState = 'fading-out';
    this.cdr.detectChanges();

    setTimeout(() => {
      this.slideCorrente = index;
      this.aggiornaCorrente();
      this.slideTransitionState = 'fading-in';
      this.cdr.detectChanges();

      setTimeout(() => {
        this.slideTransitionState = 'idle';
        this.cdr.detectChanges();
        this.startAutoplay();
      }, 300);
    }, 300);
  }

  private avantiAutomatico(): void {
    if (this.tuttiIFilm.length === 0) {
      return;
    }
    this.changeSlide((this.slideCorrente + 1) % this.tuttiIFilm.length);
  }

  private startAutoplay(): void {
    this.stopAutoplay();
    if (this.tuttiIFilm.length <= 1) {
      return;
    }
    this.autoplayTimer = window.setInterval(() => this.avantiAutomatico(), 6000);
  }

  private stopAutoplay(): void {
    if (this.autoplayTimer !== undefined) {
      window.clearInterval(this.autoplayTimer);
      this.autoplayTimer = undefined;
    }
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