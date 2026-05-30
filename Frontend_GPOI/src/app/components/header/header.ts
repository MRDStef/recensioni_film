import { Component } from '@angular/core';
import { Router, RouterLink } from '@angular/router';
import { CommonModule } from '@angular/common';
import { Auth } from '../../services/auth';

@Component({
  selector: 'app-header',
  standalone: true,
  imports: [CommonModule, RouterLink],
  templateUrl: './header.html',
  styleUrl: './header.css'
})
export class Header {
  mobileMenuAperto: boolean = false;

  constructor(public authService: Auth, private router: Router) {}

  toggleMobileMenu(): void {
    this.mobileMenuAperto = !this.mobileMenuAperto;
  }

  logout(): void {
    this.authService.logout();
    this.router.navigate(['/login']);
  }
}