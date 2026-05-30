import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { Film } from '../../services/film';
import { Recensione } from '../../services/recensione';
import { Auth } from '../../services/auth';
import { ChangeDetectorRef } from '@angular/core';

@Component({
  selector: 'app-film-detail',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './film-detail.html',
  styleUrl: './film-detail.css'
})
export class FilmDetail implements OnInit {
  film: any = null;
  recensioni: any[] = [];
  caricamento: boolean = true;
  errore: string = '';
  successMessage: string = '';
  hoverValutazione: number = 0;

  // Form recensione
  nuovaValutazione: number = 0;
  nuovaDescrizione: string = '';
  invioInCorso: boolean = false;

  constructor(
    private route: ActivatedRoute,
    private filmService: Film,
    private recensioneService: Recensione,
    public authService: Auth,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
      const id = Number(this.route.snapshot.paramMap.get('id'));
      console.log('ID film:', id);
      this.caricaFilm(id);
      this.caricaRecensioni(id);
  }

  caricaFilm(id: number): void {
      this.filmService.getById(id).subscribe({
        next: (data) => {
          console.log('Film ricevuto:', data);
          this.film = data;
          this.caricamento = false;
          this.cdr.detectChanges();
          console.log('caricamento:', this.caricamento);
          console.log('film:', this.film);
        },
        error: (err) => {
          console.log('Errore:', err);
          this.errore = 'Film non trovato';
          this.caricamento = false;
        }
      });
  }

  caricaRecensioni(id: number): void {
    this.recensioneService.getByFilm(id).subscribe({
      next: (data) => {
        const nomeUtente = this.authService.getNomeUtente();
        this.recensioni = data.sort((a, b) => {
          if (a.nome_utente === nomeUtente) return -1;
          if (b.nome_utente === nomeUtente) return 1;
          return 0;
        });
        this.cdr.detectChanges();
      },
      error: () => console.error('Errore caricamento recensioni')
    });
  }

  setValutazione(valore: number): void {
    this.nuovaValutazione = valore;
  }

  inviaRecensione(): void {
    if (this.nuovaValutazione === 0) {
      this.errore = 'Seleziona una valutazione';
      return;
    }

    this.invioInCorso = true;
    this.errore = '';

    this.recensioneService.add(this.film.id_film, this.nuovaValutazione, this.nuovaDescrizione).subscribe({
      next: () => {
        this.successMessage = 'Recensione aggiunta!';
        this.nuovaValutazione = 0;
        this.nuovaDescrizione = '';
        this.invioInCorso = false;
        this.cdr.detectChanges();
        this.caricaRecensioni(this.film.id_film);
        setTimeout(() => { this.successMessage = ''; this.cdr.detectChanges(); }, 3000);
      },
      error: () => {
        this.errore = 'Errore durante l\'invio della recensione';
        this.invioInCorso = false;
        this.cdr.detectChanges();
      }
    });
  }
  
  eliminaRecensione(idRecensione: number): void {
    if (!confirm('Sei sicuro di voler eliminare questa recensione?')) return;
    
    this.recensioneService.delete(idRecensione).subscribe({
      next: () => {
        this.recensioni = this.recensioni.filter(r => r.id_recensione !== idRecensione);
        this.cdr.detectChanges();
      },
      error: () => alert('Errore durante l\'eliminazione')
    });
  }

  renderStelle(valutazione: number): string {
    return '★'.repeat(valutazione) + '☆'.repeat(5 - valutazione);
  }

  getAnno(data: string): number {
    return new Date(data).getFullYear();
  }

  goBack(): void {
    this.router.navigate(['/home']);
  }
}