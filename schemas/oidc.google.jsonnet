local claims = {
  email_verified: true,
} + std.extVar('claims');

{
  identity: {
 
    traits: {
      [if 'email' in claims && claims.email_verified then 'email' else null]: claims.email,
      avatar: claims.picture,
      anchor: "google",
      names: {
       fullname: claims.name,
       username: claims.given_name
      }
    },
  },
}