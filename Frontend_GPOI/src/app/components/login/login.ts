import { Component } from '@angular/core';
import { Router } from '@angular/router';
import { FormsModule } from '@angular/forms';
import { CommonModule } from '@angular/common';
import { Auth } from '../../services/auth';

@Component({
  selector: 'app-login',
  standalone: true,
  imports: [FormsModule, CommonModule],
  templateUrl: './login.html',
  styleUrl: './login.css'
})
export class Login {
  email: string = '';
  password: string = '';
  errore: string = '';

  constructor(private authService: Auth, private router: Router) {}

  onLogin(): void {
    if (!this.email || !this.password) {
      this.errore = 'Compila tutti i campi';
      return;
    }

    this.authService.login(this.email, this.password).subscribe({
      next: () => {
        this.router.navigate(['/home']);
      },
      error: () => {
        this.errore = 'Email o password errati';
      }
    });
  }

  goToRegister(): void {
    this.router.navigate(['/register']);
  }
}