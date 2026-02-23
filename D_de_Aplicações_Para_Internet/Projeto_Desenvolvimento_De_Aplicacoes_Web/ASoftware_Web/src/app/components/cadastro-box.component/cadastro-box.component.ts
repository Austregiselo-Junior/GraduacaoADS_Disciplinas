import { CommonModule } from '@angular/common';
import { Component } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { Router, RouterModule } from '@angular/router';


@Component({
  selector: 'app-cadastro-box',
  imports: [FormsModule, CommonModule, RouterModule],
  templateUrl: './cadastro-box.component.html',
  styleUrl: './cadastro-box.component.css',
})
export class CadastroBoxComponent {
username: string = '';
  password: string = '';
  confirmPassword: string = '';
  loginError: boolean = false;

  constructor(private router: Router) {
}

  cadastrar() {
    if (this.password === this.confirmPassword) {
      this.router.navigate(['/home']);
      this.loginError = false; 
    } else {
      this.loginError = true;
    }
  }

  GoBack() {
    this.router.navigate(['/land']);
  }
}

