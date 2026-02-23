import { ComponentFixture, TestBed } from '@angular/core/testing';

import { CadastroBoxComponent } from './cadastro-box.component';

describe('CadastroBoxComponent', () => {
  let component: CadastroBoxComponent;
  let fixture: ComponentFixture<CadastroBoxComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [CadastroBoxComponent]
    })
    .compileComponents();

    fixture = TestBed.createComponent(CadastroBoxComponent);
    component = fixture.componentInstance;
    await fixture.whenStable();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
