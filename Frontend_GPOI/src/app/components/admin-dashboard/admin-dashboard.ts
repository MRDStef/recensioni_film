import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Film } from '../../services/film';
import { Recensione } from '../../services/recensione';
import { Auth } from '../../services/auth';
import {ChangeDetectorRef } from '@angular/core';

@Component({
  selector: 'app-admin-dashboard',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './admin-dashboard.html',
  styleUrl: './admin-dashboard.css'
})
export class AdminDashboard implements OnInit {
  film: any[] = [];
  recensioni: any[] = [];
  caricamento: boolean = true;
  errore: string = '';
  successMessage: string = '';
  invioInCorso: boolean = false;

  // Form aggiunta film
  nuovoFilm = {
    titolo: '',
    genere: '',
    regista: '',
    data_pubblicazione: '',
    descrizione: ''
  };
  locandina: File | null = null;

  constructor(
    private filmService: Film,
    private recensioneService: Recensione,
    public authService: Auth,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    if (!this.authService.isAdmin()) {
      this.router.navigate(['/home']);
      return;
    }
    this.caricaFilm();
    this.caricaRecensioni();
  }

  caricaFilm(): void {
    this.filmService.getAll().subscribe({
      next: (data) => {
        this.film = data;
        this.caricamento = false;
      },
      error: () => {
        this.errore = 'Errore nel caricamento dei film';
        this.caricamento = false;
      }
    });
  }

  caricaRecensioni(): void {
    this.recensioneService.getAll().subscribe({
      next: (data) => this.recensioni = data,
      error: () => console.error('Errore caricamento recensioni')
    });
  }

  onLocandinaChange(event: any): void {
      this.locandina = event.target.files[0] ?? null;
      this.cdr.detectChanges();
  }

  aggiungiFilm(): void {
    console.log('aggiungiFilm chiamato');
    console.log('nuovoFilm:', this.nuovoFilm);
    console.log('locandina:', this.locandina);
    if (!this.nuovoFilm.titolo || !this.nuovoFilm.genere || !this.nuovoFilm.data_pubblicazione) {
      this.errore = 'Compila tutti i campi obbligatori';
      return;
    }

    this.invioInCorso = true;
    this.errore = '';

    const formData = new FormData();
    formData.append('titolo', this.nuovoFilm.titolo);
    formData.append('genere', this.nuovoFilm.genere);
    formData.append('regista', this.nuovoFilm.regista);
    formData.append('descrizione', this.nuovoFilm.descrizione);
    formData.append('data_pubblicazione', this.nuovoFilm.data_pubblicazione);
    if (this.locandina) {
      formData.append('locandina', this.locandina);
    }

    this.filmService.add(formData).subscribe({
      next: (res) => {
        console.log('Risposta backend:', res);
        this.successMessage = 'Film aggiunto con successo!';
        this.nuovoFilm = { titolo: '', genere: '', regista: '', data_pubblicazione: '', descrizione: '' };
        this.locandina = null;
        this.invioInCorso = false;
        this.cdr.detectChanges();
        this.caricaFilm();
        setTimeout(() => this.successMessage = '', 3000);
      },
      error: (err) => {
        console.log('Errore backend:', err);
        this.errore = 'Errore durante l\'aggiunta del film';
        this.invioInCorso = false;
      }
    });
  }

  eliminaFilm(id: number): void {
    if (!confirm('Sei sicuro di voler eliminare questo film?')) return;

    this.filmService.delete(id).subscribe({
      next: () => {
        this.film = this.film.filter(f => f.id_film !== id);
        this.successMessage = 'Film eliminato';
        setTimeout(() => this.successMessage = '', 3000);
      },
      error: () => {
        this.errore = 'Errore durante l\'eliminazione del film';
      }
    });
  }

  eliminaRecensione(id: number): void {
    if (!confirm('Sei sicuro di voler eliminare questa recensione?')) return;

    this.recensioneService.delete(id).subscribe({
      next: () => {
        this.recensioni = this.recensioni.filter(r => r.id_recensione !== id);
        this.successMessage = 'Recensione eliminata';
        setTimeout(() => this.successMessage = '', 3000);
      },
      error: () => {
        this.errore = 'Errore durante l\'eliminazione della recensione';
      }
    });
  }

  renderStelle(valutazione: number): string {
    return '★'.repeat(valutazione) + '☆'.repeat(5 - valutazione);
  }
}