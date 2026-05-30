import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Auth } from '../../services/auth';

@Component({
  selector: 'app-register',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './register.html',
  styleUrl: './register.css'
})
export class Register {
  nome_utente: string = '';
  email: string = '';
  password: string = '';
  conferma_password: string = '';
  errore: string = '';

  constructor(private authService: Auth, private router: Router) {}

  onRegister(): void {
    if (!this.nome_utente || !this.email || !this.password || !this.conferma_password) {
      this.errore = 'Compila tutti i campi';
      return;
    }

    if (this.password !== this.conferma_password) {
      this.errore = 'Le password non coincidono';
      return;
    }

    this.authService.register(this.nome_utente, this.email, this.password).subscribe({
      next: () => {
        this.router.navigate(['/login']);
      },
      error: (err) => {
        if (err.status === 409) {
          this.errore = 'Email già in uso';
        } else {
          this.errore = 'Errore durante la registrazione';
        }
      }
    });
  }

  goToLogin(): void {
    this.router.navigate(['/login']);
  }
}