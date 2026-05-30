import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Auth } from './auth';

@Injectable({
  providedIn: 'root',
})
export class Recensione {
  private apiUrl = 'http://localhost:8080/api';

  constructor(private http: HttpClient, private authService: Auth) {}

  private authHeaders(): HttpHeaders {
    return new HttpHeaders({
      'Authorization': `Bearer ${this.authService.getToken()}`,
      'Content-Type': 'application/json'
    });
  }

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/recensioni`);
  }

  getByFilm(idFilm: number): Observable<any[]> {
    return this.http.get<any[]>(`${this.apiUrl}/film/${idFilm}/recensioni`);
  }

  add(idFilm: number, valutazione: number, descrizione: string): Observable<any> {
    return this.http.post(
      `${this.apiUrl}/film/${idFilm}/recensioni`,
      { valutazione, descrizione },
      { headers: this.authHeaders() }
    );
  }

  delete(idRecensione: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/recensioni/${idRecensione}`, {
      headers: this.authHeaders()
    });
  }
}
