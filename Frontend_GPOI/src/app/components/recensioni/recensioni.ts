import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';
import { Router } from '@angular/router';
import { Recensione } from '../../services/recensione';
import { Auth } from '../../services/auth';
import { ChangeDetectorRef } from '@angular/core';
import { Account } from '../../services/account';

@Component({
  selector: 'app-recensioni',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './recensioni.html',
  styleUrl: './recensioni.css'
})
export class Recensioni implements OnInit {
  recensioni: any[] = [];
  caricamento: boolean = true;
  errore: string = '';

  constructor(
    private recensioneService: Recensione,
    private accountService: Account,
    public authService: Auth,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) { }

  ngOnInit(): void {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }

    this.accountService.getProfile().subscribe({
      next: (data) => {
        this.recensioni = data.recensioni;
        this.caricamento = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.errore = 'Errore nel caricamento delle recensioni';
        this.caricamento = false;
        this.cdr.detectChanges();
      }
    });
  }

  goToFilm(idFilm: number): void {
    this.router.navigate(['/film', idFilm]);
  }

  eliminaRecensione(idRecensione: number): void {
    if (!confirm('Sei sicuro di voler eliminare questa recensione?')) return;

    this.recensioneService.delete(idRecensione).subscribe({
      next: () => {
        this.recensioni = this.recensioni.filter(r => r.id_recensione !== idRecensione);
      },
      error: () => {
        alert('Errore durante l\'eliminazione');
      }
    });
  }

  renderStelle(valutazione: number): string {
    return '★'.repeat(valutazione) + '☆'.repeat(5 - valutazione);
  }
}