import { User } from './user';

describe('User', () => {
  it('has name', () => {
    const user = new User('Super Cat', '');
    expect(user.name).toBe('Super Cat');
  });

  it('has email', () => {
    const user = new User('', 'foo@bar.com');
    expect(user.email).toBe('foo@bar.com');
  });
});