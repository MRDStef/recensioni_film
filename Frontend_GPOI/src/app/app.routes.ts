import { Routes } from '@angular/router';
import { Login } from "./components/login/login";
import { Home } from "./components/home/home";
import { Register } from './components/register/register';
import { Recensioni } from './components/recensioni/recensioni';
import { AdminDashboard } from "./components/admin-dashboard/admin-dashboard";
import { FilmDetail } from "./components/film-detail/film-detail";
import { Profilo } from "./components/profilo/profilo";

export const routes: Routes = [
    { path: 'profilo', component: Profilo },
    { path: 'film/:id', component: FilmDetail },
    { path: 'admin', component: AdminDashboard },
    { path: 'recensioni', component: Recensioni },
    { path: 'register', component: Register },
    { path: 'login',component: Login },
    { path: 'home',component: Home },
    { path: '', redirectTo: 'home', pathMatch: 'full' }
];
