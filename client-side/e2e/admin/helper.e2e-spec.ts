import { browser, element, by, protractor } from 'protractor';

// NOTICE: Redis and rails servers must be running for this to work

// To sign in a specific user. 
export function SignIn(): void {

  browser.get('');

  element(by.id('sign-in-link')).click();

  element(by.id('name')).sendKeys('admin');
  element(by.id('email')).sendKeys('admin@admin.com');

  element(by.id('sign-in-submit')).click();
}

export function LogOut(): void {

  browser.get('');
  element(by.id('admin-log-out')).click();
}

// Create a dummy user. Will be remove later
export function AddUser(userName: string, userEmail: string): void {

  SignIn();

  element(by.id('admin-user-link')).click();

  element(by.id('add-user')).click();

  element(by.id('name')).sendKeys(userName);
  element(by.id('email')).sendKeys(userEmail);

  browser.executeScript('window.scrollTo(0,0);').then(() => {
    element(by.id('user-detail-save')).click();
  });
}

// To remove a specific user. For clean up purposes
export function RemoveUser(userName: string): void {

  SignIn();

  element(by.id('admin-user-link')).click();

  let elementToClick = element(by.id(`delete-${userName}`));

  // wait for the element to be clickable 
  browser.wait(protractor.ExpectedConditions.elementToBeClickable(elementToClick), 10000)
    .then (() => {
      // little hack to scroll down the whole page to move where the delete button is
      browser.executeScript('window.scrollTo(10000,10000);').then(() => {
        elementToClick.click();

        browser.get('');
      });
    });
}

// Create a dummy chat room. Will be remove later
export function AddChatRoom(title: string): void {

  SignIn();

  element(by.id('admin-chat-room-link')).click();

  element(by.id('add-chat-room')).click();

  element(by.id('title')).sendKeys(title);

  browser.executeScript('window.scrollTo(0,0);').then(() => {
    element(by.id('chat-room-detail-save')).click();
  });
}

// To remove a specific chat room. For clean up purposes
export function RemoveChatRoom(title: string): void {

  SignIn();

  element(by.id('admin-chat-room-link')).click();

  let elementToClick = element(by.id(`delete-${title}`));

  // wait for the element to be clickable 
  browser.wait(protractor.ExpectedConditions.elementToBeClickable(elementToClick), 10000)
    .then (() => {
      // little hack to scroll down the whole page to move where the delete button is
      browser.executeScript('window.scrollTo(10000,10000);').then(() => {
        elementToClick.click();

        browser.get('');
      });
    });
}

export function GetRandomInt(min: number, max: number): number {
  min = Math.ceil(min);
  max = Math.floor(max);
  return Math.floor(Math.random() * (max - min)) + min;
}
