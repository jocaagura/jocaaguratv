abstract class Either<L, R> {
  const Either();
  T when<T>(
    T Function(L) left,
    T Function(R) right,
  ) {
    if (this is Left<L, R>) {
      return left((this as Left<L, R>).value);
    }
    return right((this as Right<L, R>).value);
  }
}

class Left<L, R> extends Either<L, R> {
  const Left(this.value);
  final L value;
}

class Right<L, R> extends Either<L, R> {
  const Right(this.value);
  final R value;
}
