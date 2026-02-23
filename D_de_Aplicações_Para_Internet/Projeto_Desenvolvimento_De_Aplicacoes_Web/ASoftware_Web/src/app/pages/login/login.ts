import { Component } from '@angular/core';
import { LoginBoxComponent } from '../../components/login-box-component/login-box-component';
import { LogoComponent } from '../../components/logo-component/logo-component';
import { LandHeaderComponent } from '../../components/land-header.component/land-header.component';
import { LandFooterComponent } from '../../components/land-footer.component/land-footer.component';

@Component({
  selector: 'app-login',
  imports: [LoginBoxComponent, LogoComponent, LandHeaderComponent, LandFooterComponent],
  templateUrl: './login.html',
  styleUrl: './login.css',
})
export class Login {

}
