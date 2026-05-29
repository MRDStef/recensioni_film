import { provideHttpClient } from '@angular/common/http';
import { HttpTestingController, provideHttpClientTesting } from '@angular/common/http/testing';
import { ComponentFixture, TestBed } from '@angular/core/testing';

import { Home } from './home';

describe('Home', () => {
  let component: Home;
  let fixture: ComponentFixture<Home>;
  let httpMock: HttpTestingController;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [Home],
      providers: [provideHttpClient(), provideHttpClientTesting()],
    })
      .overrideComponent(Home, { set: { providers: [] } })
      .compileComponents();

    fixture = TestBed.createComponent(Home);
    component = fixture.componentInstance;
    httpMock = TestBed.inject(HttpTestingController);
    fixture.detectChanges();
  });

  afterEach(() => {
    httpMock.verify();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });

  it('should request featured film and categories from api', () => {
    const featuredReq = httpMock.expectOne('http://localhost:8080/api/film/evidenza');
    expect(featuredReq.request.method).toBe('GET');
    featuredReq.flush({
      titolo: 'The Batman',
      descrizione: 'Descrizione test',
      locandine: [{ id: 1, url: '', alt: 'Slide 1' }],
    });

    const genreReqs = httpMock.match((req) => req.url === 'http://localhost:8080/api/film');
    expect(genreReqs.length).toBe(3);
    genreReqs.forEach((req) => {
      expect(req.request.method).toBe('GET');
      req.flush([]);
    });
  });
});
