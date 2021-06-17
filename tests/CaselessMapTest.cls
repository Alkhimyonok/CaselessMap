/**
 * Created by VeronikaAlkhimenok on 6/14/2021.
 */

@IsTest
private class CaselessMapTest {
	private static final Integer MAP_SIZE = 2000;
	private static final Integer TARGET_INDEX_MAP = 1000;
	private static final String EXCEPTION_MESSAGE_NULL_PARAMETER = 'Null parameter passed to method.';
	private static final String EXCEPTION_MESSAGE_NULL_ITEM = 'Passed list contains a null object.';

	@IsTest
	private static void constructorShouldCreateInstanceWithEmptyInnerMapWhenExecutedConstructorWithoutParameters() {
		CaselessMap mapWrapper = new CaselessMap();
		System.assert(mapWrapper.innerMap.isEmpty(),
				'Should create an empty map');
	}

	@IsTest
	private static void constructorShouldCreateInstanceWithCaseInsensitiveInnerMapWhenExecutedConstructorWithMapParameter() {
		Map<String, SObject> mapToCopy = generateStringsToAccountsMap(MAP_SIZE);
		CaselessMap caselessMap = new CaselessMap(mapToCopy);
		String keyToSearch = getKeyByIndex(mapToCopy, TARGET_INDEX_MAP);
		System.assertEquals(caselessMap.get(keyToSearch.toLowerCase()), caselessMap.get(keyToSearch.toUpperCase()),
				'Values should be the same regardless of the case of keys');
	}

	@IsTest
	private static void constructorShouldThrowContractViolationExceptionWhenExecutedConstructorWithNullMapParameter() {
		ContractViolationException expectedException = new ContractViolationException(EXCEPTION_MESSAGE_NULL_PARAMETER);
		ContractViolationException resultException;
		try {
			Map<String, SObject> sObjectMap;
			CaselessMap caselessMap = new CaselessMap(sObjectMap);
		} catch (ContractViolationException e) {
			resultException = e;
		}
		System.assertEquals(expectedException.getMessage(), resultException.getMessage(),
				'Should not handle occurred exceptions');
	}

	@IsTest
	private static void constructorShouldThrowContractViolationExceptionWhenExecutedConstructorWithMapParameterContainsNullKey() {
		ContractViolationException expectedException = new ContractViolationException(EXCEPTION_MESSAGE_NULL_ITEM);
		ContractViolationException resultException;
		try {
			Map<String, SObject> sObjectMap = new Map<String, SObject>();
			sObjectMap.put(null, null);
			CaselessMap caselessMap = new CaselessMap(sObjectMap);
		} catch (ContractViolationException e) {
			resultException = e;
		}
		System.assertEquals(expectedException.getMessage(), resultException.getMessage(),
				'Should not handle occurred exceptions');
	}

	@IsTest
	private static void constructorShouldCreateInstanceWithCaseInsensitiveInnerMapWhenExecutedConstructorWithListParameter() {
		List<Account> accounts = generateAccountsList(MAP_SIZE);
		CaselessMap mapWrapper = new CaselessMap(accounts);
		String keyToSearch = accounts.get(TARGET_INDEX_MAP).Id;
		System.assertEquals(mapWrapper.get(keyToSearch.toLowerCase()), mapWrapper.get(keyToSearch.toUpperCase()),
				'Values should be the same regardless of the case of keys');
	}

	@IsTest
	private static void constructorShouldThrowContractViolationExceptionWhenExecutedConstructorWithNullListParameter() {
		ContractViolationException expectedException = new ContractViolationException(EXCEPTION_MESSAGE_NULL_PARAMETER);
		ContractViolationException resultException;
		try {
			List<SObject> sObjectList;
			CaselessMap caselessMap = new CaselessMap(sObjectList);
		} catch (ContractViolationException e) {
			resultException = e;
		}
		System.assertEquals(expectedException.getMessage(), resultException.getMessage(),
				'Should not handle occurred exceptions');
	}

	@IsTest
	private static void constructorShouldThrowContractViolationExceptionWhenExecutedConstructorWithListParameterContainsNull() {
		ContractViolationException expectedException = new ContractViolationException(EXCEPTION_MESSAGE_NULL_ITEM);
		ContractViolationException resultException;
		try {
			List<SObject> sObjectList = new List<SObject>();
			sObjectList.add(null);
			CaselessMap caselessMap = new CaselessMap(sObjectList);
		} catch (ContractViolationException e) {
			resultException = e;
		}
		System.assertEquals(expectedException.getMessage(), resultException.getMessage(),
				'Should not handle occurred exceptions');
	}

	@IsTest
	private static void putShouldAddItemToInnerMapWhenExecutedPutMethod() {
		CaselessMap mapWrapper = new CaselessMap();
		mapWrapper.put('Id', new Account(Name = 'Test Name'));
		System.assertEquals(mapWrapper.size(), 1,
				'Put method should to add 1 item to inner map');
	}

	@IsTest
	private static void putShouldThrowContractViolationExceptionWhenExecutedPutMethodWithNullKey() {
		ContractViolationException expectedException = new ContractViolationException(EXCEPTION_MESSAGE_NULL_PARAMETER);
		ContractViolationException resultException;
		try {
			CaselessMap caselessMap = new CaselessMap();
			String id;
			caselessMap.put(id, new Account(Name = 'Test Name'));
		} catch (ContractViolationException e) {
			resultException = e;
		}
		System.assertEquals(expectedException.getMessage(), resultException.getMessage(),
				'Should not handle occurred exceptions');
	}

	@IsTest
	private static void getShouldThrowContractViolationExceptionWhenExecutedGetMethodWithNullParameter() {
		ContractViolationException expectedException = new ContractViolationException(EXCEPTION_MESSAGE_NULL_PARAMETER);
		ContractViolationException resultException;
		try {
			CaselessMap caselessMap = new CaselessMap();
			String id;
			caselessMap.get(id);
		} catch (ContractViolationException e) {
			resultException = e;
		}
		System.assertEquals(expectedException.getMessage(), resultException.getMessage(),
				'Should not handle occurred exceptions');
	}

	private static Map<String, SObject> generateStringsToAccountsMap(Integer mapSize) {
		return new Map<String, SObject>(generateAccountsList(mapSize));
	}

	private static List<Account> generateAccountsList(Integer mapSize) {
		List<Account> accountsToInsert = new List<Account>();
		for (Integer i = 0; i < mapSize; i++) {
			accountsToInsert.add(new Account(
					Id = fflib_IDGenerator.generate(Account.getSObjectType()),
					Name = 'Test Name ' + i));
		}
		return accountsToInsert;
	}

	private static String getKeyByIndex(Map<String, SObject> mapForSearch, Integer index) {
		List<String> idList = new List<String>(mapForSearch.keySet());
		return idList.get(index);
	}

}
