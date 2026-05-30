import { HttpClient, HttpHeaders } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Observable } from 'rxjs';
import { Auth } from './auth';

@Injectable({
  providedIn: 'root',
})
export class Film {
  private apiUrl = 'http://localhost:8080/api/film';

  constructor(private http: HttpClient, private authService: Auth) {}

  private authHeaders(): HttpHeaders {
    return new HttpHeaders({
      'Authorization': `Bearer ${this.authService.getToken()}`
    });
  }

  getAll(): Observable<any[]> {
    return this.http.get<any[]>(this.apiUrl);
  }

  getById(id: number): Observable<any> {
    return this.http.get<any>(`${this.apiUrl}/${id}`);
  }

  add(formData: FormData): Observable<any> {
    return this.http.post(this.apiUrl, formData, {
      headers: this.authHeaders()
    });
  }

  update(id: number, dati: any): Observable<any> {
    return this.http.put(`${this.apiUrl}/${id}`, dati, {
      headers: this.authHeaders()
    });
  }

  delete(id: number): Observable<any> {
    return this.http.delete(`${this.apiUrl}/${id}`, {
      headers: this.authHeaders()
    });
  }
}
