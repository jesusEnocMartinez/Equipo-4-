import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
import { Persona } from '../Persona/Modelo/Persona';

@Injectable({
  providedIn: 'root'
})
export class ServiceService {

  constructor(private http: HttpClient) { }

Url = 'http://localhost:8080/api/personarest';
   getPersonas() {
     return this.http.get<Persona[]>(this.Url);
   }
   createpersona(persona: Persona) {
    return this.http.post<Persona>(this.Url, persona);
   }
    getpersonaclave(clave: number) {
    return this.http.get<Persona>(this.Url + '/' + clave);

  }
    Updatepersona(persona: Persona) {
    return this.http.put<Persona>(this.Url + '/', persona);

  }
    deletePersona(persona: Persona) {
    return this.http.delete<Persona>(this.Url + '/' + persona.clave);
 }
}
