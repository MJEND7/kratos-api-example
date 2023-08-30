# Kratos API Playground 🚀

Are you as enthusiastic about Ory Kratos as I am? If you've found their API documentation a bit challenging to wrap your head around at times, I've got a solution for you! I've put together this playground to make your experience smoother. With the help of Insomnia, you can now effortlessly test every aspect yourself. Moreover, you can utilize this as a dependable reference for your projects, whether in development or production. Have a blast exploring the possibilities and make your journey with Ory Kratos much more enjoyable and productive!

## Comprehensive Documentation Links 📖

To complement this playground, feel free to delve into the official documentation for a deep dive:

- [Welcome to Ory Documentation](https://www.ory.sh/docs/welcome)
- [Ory Kratos Introduction](https://www.ory.sh/docs/kratos/ory-kratos-intro)
- [Deploying Ory Kratos - A Practical Guide](https://www.ory.sh/docs/kratos/guides/deploy-kratos-example)
- [Ory Kratos API Reference](https://www.ory.sh/docs/reference/api)

Additionally, if you're ready to take things to the next level, check out these resources:

- [Kratos Next: A Practical Example](https://github.com/spa5k/kratos-next)
- [Protect Your Page with Login: Next.js Implementation](https://github.com/ory/docs/tree/master/code-examples/protect-page-login/nextjs)

Let's make working with Ory Kratos a breeze! 🌟

## Makefile Commands

This section provides an overview of the available Makefile commands for managing your project. Below you'll find a list of commands that you can use to perform various tasks related to your project setup, development, and deployment.

- `make dev`: Run the development server using the dev_kratos.yml configuration.
- `make start`: Start the production server using the kratos.yml configuration.
- `make download`: Download a new version of Ory Kratos.
- `make dev_mig`: Run database migration in the development environment.
- `make migration`: Run database migration in the production environment.
- `make setup-postgres`: Install and set up PostgreSQL for your project.

To use any of these commands, open your terminal and navigate to the project directory. Then, simply type `make` followed by the desired command. For example, to start the development server, run `make dev`.

## Project Configuration

Before using the Makefile commands, make sure to adjust the configuration variables at the beginning of the Makefile to match your project setup. Specifically, review and update the following variables as needed:

- `FILENAME`: The name of the Kratos executable.
- `VERSION`: The version of Ory Kratos you want to download.
- `DB_YOUR_NAME`: The username for your PostgreSQL user.
- `DB_PASSWORD`: The password for your PostgreSQL user.
- `DB_NAME`: The name of your PostgreSQL database.

Remember to replace placeholders like `<YOUR_PASSWORD_HERE>` with your actual values.

## Additional Information

If you encounter any issues or need further assistance, please refer to the official Ory Kratos documentation and relevant resources. Feel free to modify this README to provide additional project-specific information as needed.

Happy coding!
