import { Routes } from '@angular/router';
import { Login } from './pages/login/login';
import { HomeComponent } from './components/home-component/home-component';
import { Land } from './pages/land/land';
import { Cadastro } from './pages/cadastro/cadastro';
import { AboutUs } from './pages/about-us/about-us';

export const routes: Routes = [
    { path: '', redirectTo: 'land', pathMatch: 'full' },
    { path: 'login', component: Login },
    { path: 'home', component: HomeComponent },
    { path: 'land', component: Land },
    { path: 'cadastro', component: Cadastro},
    { path: 'about-us', component: AboutUs } 
];
