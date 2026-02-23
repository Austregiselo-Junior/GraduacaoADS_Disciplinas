import { Component } from '@angular/core';
import { CadastroBoxComponent } from '../../components/cadastro-box.component/cadastro-box.component';
import { LogoComponent } from '../../components/logo-component/logo-component';
import { LandHeaderComponent } from "../../components/land-header.component/land-header.component";
import { LandFooterComponent } from '../../components/land-footer.component/land-footer.component';


@Component({
  selector: 'app-cadastro',
  imports: [LogoComponent, CadastroBoxComponent, LandHeaderComponent, LandFooterComponent],
  templateUrl: './cadastro.html',
  styleUrl: './cadastro.css',
})
export class Cadastro {

}
