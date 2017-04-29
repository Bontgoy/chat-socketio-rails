import { NgModule }             from '@angular/core';
import { RouterModule, Routes } from '@angular/router';

import { AboutComponent }      from './components/about/about.component';
import { ChatRoomComponent }   from './components/admin/chat-room/chat-room.component';
import { DashboardComponent }  from './components/dashboard/dashboard.component';
import { MessageComponent }    from './components/admin/message/message.component';
import { SignInComponent }     from './components/sign-in/sign-in.component';
import { SignUpComponent }     from './components/sign-up/sign-up.component';
import { UserComponent }       from './components/admin/user/user.component';
import { UserDetailComponent } from './components/admin/user/user-detail.component';

const routes: Routes = [
  { path: '', redirectTo: '/dashboard', pathMatch: 'full' },
  { path: 'dashboard',  component: DashboardComponent },
  { path: 'signin',  component: SignInComponent },
  { path: 'signup',  component: SignUpComponent },
  { path: 'about',  component: AboutComponent },
  { path: 'admin/user',  component: UserComponent },
  { path: 'admin/user/detail/:id', component: UserDetailComponent },
  { path: 'admin/message',  component: MessageComponent },
  { path: 'admin/chat-room',  component: ChatRoomComponent },
];
@NgModule({
  imports: [ RouterModule.forRoot(routes) ],
  exports: [ RouterModule ]
})
export class AppRoutingModule {}
