package org.kosa.mini.member;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Member {
	private String userid;
	private String passwd;
	private String name;
	private int age;
	private String birthday;
	private String email;
	private String phonenumber;
	private String address;
	private String detailaddress;
	private String sex;
	private String habit;
	private String registerTime;
	private String loginTime;
	private String admin;
	private String locked;
	private int failcount;
	private String deleteyn;

	public boolean isValid() {
		if (userid == null || userid.length() == 0)
			return false;

		if (passwd == null || passwd.length() == 0)
			return false;

		if (name == null || name.length() == 0)
			return false;

		if (birthday == null || birthday.length() == 0)
			return false;

		if (email == null || email.length() == 0)
			return false;

		if (phonenumber == null || phonenumber.length() == 0)
			return false;

		if (address == null || address.trim().length() == 0)
			return false;

		if (detailaddress == null || detailaddress.trim().length() == 0)
			return false;

		if (sex == null || sex.length() == 0)
			return false;

		return true;

	}
}
