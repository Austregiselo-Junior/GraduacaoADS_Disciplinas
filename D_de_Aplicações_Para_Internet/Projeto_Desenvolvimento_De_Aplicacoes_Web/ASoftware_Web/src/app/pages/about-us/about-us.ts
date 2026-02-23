import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';
import { LandHeaderComponent } from '../../components/land-header.component/land-header.component';
import { LandBodyComponent } from '../../components/land-body.component/land-body.component';
import { LandFooterComponent } from '../../components/land-footer.component/land-footer.component';
import { Router, RouterModule } from '@angular/router';

@Component({
  selector: 'app-about-us',
  imports: [CommonModule, LandHeaderComponent, LandBodyComponent, LandFooterComponent],
  templateUrl: './about-us.html',
  styleUrl: './about-us.css',
})
export class AboutUs {

  constructor(private router: Router) {
  }

  GoTologin() 
  {
     this.router.navigate(['/login']);
  }

}
