import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable, tap } from 'rxjs';

@Injectable({
  providedIn: 'root',
})
export class Auth {
  private apiUrl = 'http://localhost:8080/api/auth';

  constructor(private http: HttpClient) { }

  register(nome_utente: string, email: string, password: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/register`, { nome_utente, email, password });
  }

  login(email: string, password: string): Observable<any> {
    return this.http.post(`${this.apiUrl}/login`, { email, password }).pipe(
      tap((res: any) => {
        localStorage.setItem('token', res.token);
        localStorage.setItem('nome_utente', res.nome_utente);
        localStorage.setItem('ruolo', res.ruolo);
      })
    );
  }

  logout(): void {
    localStorage.removeItem('token');
    localStorage.removeItem('nome_utente');
    localStorage.removeItem('ruolo');
  }

  isLoggedIn(): boolean {
    return !!localStorage.getItem('token');
  }

  getToken(): string | null {
    return localStorage.getItem('token');
  }

  getNomeUtente(): string | null {
    return localStorage.getItem('nome_utente');
  }

  getRuolo(): string | null {
    return localStorage.getItem('ruolo');
  }

  isAdmin(): boolean {
    return this.getRuolo() === 'admin';
  }
}
