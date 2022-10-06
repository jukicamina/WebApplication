package mypackage;

import java.util.List;

public interface UserDaoAbstract {
	List<User> get();
	User get(String userName, String password);
	User get(String userName);
	boolean update(User userAccount, String userName);
	boolean save(User userAccount);
	boolean delete(String userName);
}
