# Contributing to Undercover Game 🎮

Thank you for considering contributing to Undercover Game! We welcome contributions from everyone.

## 🤝 How to Contribute

### Reporting Bugs

1. Check if the bug has already been reported in [Issues](../../issues)
2. If not, create a new issue using the Bug Report template
3. Include as much detail as possible:
   - Steps to reproduce
   - Expected vs actual behavior
   - Screenshots if applicable
   - Device and Flutter version info

### Suggesting Features

1. Check if the feature has already been suggested in [Issues](../../issues)
2. If not, create a new issue using the Feature Request template
3. Clearly describe the feature and its benefits
4. Consider including mockups or examples

### Code Contributions

#### Getting Started

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/YOUR_USERNAME/undercover_game.git
   ```
3. Add the upstream repository:
   ```bash
   git remote add upstream https://github.com/ORIGINAL_OWNER/undercover_game.git
   ```
4. Create a new branch for your feature:
   ```bash
   git checkout -b feature/your-feature-name
   ```

#### Making Changes

1. Make your changes in your feature branch
2. Follow the existing code style and conventions
3. Run tests to ensure nothing is broken:
   ```bash
   flutter test
   ```
4. Format your code:
   ```bash
   dart format .
   ```
5. Check for issues:
   ```bash
   flutter analyze
   ```

#### Code Style Guidelines

- Follow [Effective Dart](https://dart.dev/guides/language/effective-dart) guidelines
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use const constructors where possible

#### Committing Changes

1. Write clear, concise commit messages:
   ```
   feat: Add timer feature to game rounds
   fix: Resolve word reveal animation issue
   docs: Update README with new features
   style: Format code according to Dart standards
   refactor: Simplify game state management
   test: Add tests for player elimination
   ```

2. Commit your changes:
   ```bash
   git add .
   git commit -m "feat: Your feature description"
   ```

3. Keep your branch up to date:
   ```bash
   git fetch upstream
   git rebase upstream/main
   ```

#### Submitting Pull Requests

1. Push your changes to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```

2. Go to the original repository and create a Pull Request

3. In your PR description:
   - Describe what changes you made
   - Reference any related issues
   - Include screenshots for UI changes
   - List any breaking changes

4. Wait for review and address any feedback

## 📝 Contribution Ideas

### Easy (Good First Issues)
- Add new word pairs to the database
- Fix typos in documentation
- Improve error messages
- Add more comments to code

### Medium
- Add sound effects
- Implement animations
- Add dark mode support
- Create new themes
- Add language translations

### Advanced
- Implement online multiplayer
- Add game statistics/history
- Create custom word list feature
- Implement timed rounds
- Add achievements system

## 🧪 Testing

- All code changes should include appropriate tests
- Run existing tests before submitting PR
- Add new tests for new features
- Ensure test coverage doesn't decrease

## 📚 Documentation

- Update README.md if you add new features
- Update GAME_GUIDE.md for gameplay changes
- Add comments to complex code
- Update documentation files as needed

## 🎨 Design Guidelines

- Follow Material Design 3 principles
- Maintain consistency with existing UI
- Ensure accessibility (contrast, font sizes)
- Test on different screen sizes
- Consider different device orientations

## ⚖️ Code of Conduct

### Our Pledge

We pledge to make participation in our project a harassment-free experience for everyone, regardless of age, body size, disability, ethnicity, gender identity and expression, level of experience, nationality, personal appearance, race, religion, or sexual identity and orientation.

### Our Standards

**Positive behavior includes:**
- Using welcoming and inclusive language
- Being respectful of differing viewpoints
- Gracefully accepting constructive criticism
- Focusing on what is best for the community
- Showing empathy towards others

**Unacceptable behavior includes:**
- Trolling, insulting comments, or personal attacks
- Public or private harassment
- Publishing others' private information
- Other conduct considered inappropriate

## 📄 License

By contributing, you agree that your contributions will be licensed under the MIT License.

## ❓ Questions?

Feel free to:
- Open an issue with your question
- Check existing issues and discussions
- Refer to Flutter documentation: https://docs.flutter.dev

## 🙏 Thank You!

Your contributions help make Undercover Game better for everyone! We appreciate your time and effort.

Happy coding! 🚀
