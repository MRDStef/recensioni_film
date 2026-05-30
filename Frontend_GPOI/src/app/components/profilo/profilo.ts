import { Component, OnInit, ChangeDetectorRef } from '@angular/core';
import { CommonModule } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { Router } from '@angular/router';
import { Account } from '../../services/account';
import { Auth } from '../../services/auth';

@Component({
  selector: 'app-profilo',
  standalone: true,
  imports: [CommonModule, FormsModule],
  templateUrl: './profilo.html',
  styleUrl: './profilo.css'
})
export class Profilo implements OnInit {
  account: any = null;
  recensioni: any[] = [];
  caricamento: boolean = true;
  errore: string = '';
  successMessage: string = '';

  // Form password
  nuovaPassword: string = '';
  confermaPassword: string = '';
  invioPasswordInCorso: boolean = false;

  // Avatar
  avatarFile: File | null = null;
  invioAvatarInCorso: boolean = false;

  constructor(
    private accountService: Account,
    public authService: Auth,
    private router: Router,
    private cdr: ChangeDetectorRef
  ) {}

  ngOnInit(): void {
    if (!this.authService.isLoggedIn()) {
      this.router.navigate(['/login']);
      return;
    }
    this.caricaProfilo();
  }

  caricaProfilo(): void {
    this.accountService.getProfile().subscribe({
      next: (data) => {
        this.account = data.account;
        this.recensioni = data.recensioni;
        this.caricamento = false;
        this.cdr.detectChanges();
      },
      error: () => {
        this.errore = 'Errore nel caricamento del profilo';
        this.caricamento = false;
        this.cdr.detectChanges();
      }
    });
  }

  onAvatarChange(event: any): void {
    this.avatarFile = event.target.files[0] ?? null;
    this.cdr.detectChanges();
  }

  aggiornaAvatar(): void {
    if (!this.avatarFile) {
      this.errore = 'Seleziona un file';
      return;
    }

    this.invioAvatarInCorso = true;
    this.errore = '';

    const formData = new FormData();
    formData.append('avatar', this.avatarFile);

    this.accountService.updateAvatar(formData).subscribe({
      next: (res) => {
        this.account.avatar_url = res.avatar_url;
        this.successMessage = 'Avatar aggiornato!';
        this.avatarFile = null;
        this.invioAvatarInCorso = false;
        this.cdr.detectChanges();
        setTimeout(() => { this.successMessage = ''; this.cdr.detectChanges(); }, 3000);
      },
      error: () => {
        this.errore = 'Errore durante l\'aggiornamento dell\'avatar';
        this.invioAvatarInCorso = false;
        this.cdr.detectChanges();
      }
    });
  }

  aggiornaPassword(): void {
    if (!this.nuovaPassword || !this.confermaPassword) {
      this.errore = 'Compila tutti i campi';
      return;
    }

    if (this.nuovaPassword !== this.confermaPassword) {
      this.errore = 'Le password non coincidono';
      return;
    }

    this.invioPasswordInCorso = true;
    this.errore = '';

    this.accountService.updatePassword(this.nuovaPassword, this.confermaPassword).subscribe({
      next: () => {
        this.successMessage = 'Password aggiornata!';
        this.nuovaPassword = '';
        this.confermaPassword = '';
        this.invioPasswordInCorso = false;
        this.cdr.detectChanges();
        setTimeout(() => { this.successMessage = ''; this.cdr.detectChanges(); }, 3000);
      },
      error: () => {
        this.errore = 'Errore durante l\'aggiornamento della password';
        this.invioPasswordInCorso = false;
        this.cdr.detectChanges();
      }
    });
  }

  renderStelle(valutazione: number): string {
    return '★'.repeat(valutazione) + '☆'.repeat(5 - valutazione);
  }

  getAnno(data: string): number {
    return new Date(data).getFullYear();
  }
}