import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Auth } from './auth';

@Injectable({
  providedIn: 'root',
})
export class Account {
  private apiUrl = 'http://localhost:8080/api/account';

  constructor(private http: HttpClient, private authService: Auth) { }

  private authHeaders(): HttpHeaders {
    return new HttpHeaders({
      'Authorization': `Bearer ${this.authService.getToken()}`
    });
  }

  getProfile(): Observable<any> {
    return this.http.get(`${this.apiUrl}/me`, {
      headers: this.authHeaders()
    });
  }

  updatePassword(nuova_password: string, conferma_password: string): Observable<any> {
    return this.http.put(
      `${this.apiUrl}/me`,
      { nuova_password, conferma_password },
      { headers: this.authHeaders() }
    );
  }

  updateAvatar(formData: FormData): Observable<any> {
    return this.http.put(`${this.apiUrl}/me/avatar`, formData, {
      headers: this.authHeaders()
    });
  }
}
